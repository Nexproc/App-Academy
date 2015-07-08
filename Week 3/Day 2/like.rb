require_relative 'table'

class Like < Table
  attr_accessor :id, :question_id, :user_id

  def self.tab_name
     "question_likes"
  end

  def self.likers_for_question_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        u.*
      FROM
        users u
      JOIN
        question_likes ql ON u.id = ql.user_id
      WHERE
        ql.question_id = ?
    SQL

    Like.convert(results)
  end

  def self.num_likes_for_question_id(id)
    QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        COUNT(u.*)
      FROM
        users u
      JOIN
        question_likes ql ON u.id = ql.user_id
      WHERE
        ql.question_id = ?
      GROUP BY
        ql.question_id
    SQL
  end

  def self.liked_questions_for_user_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        q.*
      FROM
        questions q
      JOIN
        question_likes ql ON q.id = ql.question_id
      WHERE
        ql.user_id = ?
    SQL

    Like.convert(results)
  end

  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        COUNT(u.*)
      FROM
        users u
      JOIN
        question_likes ql ON u.id = ql.user_id
      GROUP BY
        ql.question_id
      ORDER BY
        COUNT(u.*) DESC LIMIT ?
    SQL

    Like.convert(results)
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
end
