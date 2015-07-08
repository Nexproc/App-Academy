require_relative 'table'
require_relative 'reply'
require_relative 'question'
require_relative 'follow'
require_relative 'like'

class User < Table
  attr_accessor :id, :fname, :lname

  def self.tab_name
     "users"
  end

  def self.find_by_name(fname, lname)
    results = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT * FROM users WHERE fname = ? AND lname = ?
    SQL

    User.convert results
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    Follow.questions_for_user_id(@id)
  end

  def liked_questions
    Like.liked_questions_for_user_id(@id)
  end

  def average_karma
    QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        (CAST(COUNT(ql.id) AS FLOAT) / COUNT(DISTINCT q.author)) avg_karma
      FROM
        questions q
      LEFT OUTER JOIN
        question_likes ql ON q.id = ql.question_id
      WHERE
        q.author = ?
      GROUP BY
        q.author
    SQL
  end
end
