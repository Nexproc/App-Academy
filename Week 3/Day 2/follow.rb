require_relative 'table'

class Follow < Table
  attr_accessor :id, :question_id, :user_id

  def self.tab_name
     "question_follows"
  end

  def self.followers_for_question_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT u.*
      FROM users u
      JOIN question_follows qf ON u.id = qf.user_id
      WHERE qf.question_id = ?
    SQL

    Follow.convert results
  end

  def self.questions_for_user_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT q.*
      FROM questions q
      JOIN question_follows qf ON q.id = qf.question_id
      WHERE qf.user_id = ?
    SQL

    Follow.convert results
  end

  def self.most_followed_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
       q.*
      FROM
        questions q
      JOIN
        question_follows qf ON qf.question_id = q.id
      GROUP BY
        q.id
      ORDER BY
        COUNT(qf.user_id) DESC LIMIT ?
    SQL

    Follow.convert results
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
end
