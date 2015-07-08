require_relative 'table'
require_relative 'user'
require_relative 'question'

class Reply < Table
  attr_accessor :id, :question_id, :user_id, :parent_id, :body

  def self.tab_name
     "replies"
  end

  def self.find_by_user_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT * FROM replies WHERE user_id = ?
    SQL

    Reply.convert results
  end

  def self.find_by_question_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT * FROM replies WHERE question_id = ?
    SQL

    Reply.convert results
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
    @parent_id = options['parent_id']
    @body = options['body']
  end


  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id) if @parent_id
  end

  def child_replies
    results = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT * FROM replies WHERE parent_id = ?
    SQL

    Reply.convert results
  end
end
