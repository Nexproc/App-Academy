require_relative 'table'
require_relative 'reply'
require_relative 'follow'
require_relative 'like'
require_relative 'user'


class Question < Table
  attr_accessor :id, :title, :body, :author

  def self.tab_name
     "questions"
  end

  def self.find_by_author_id(author_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT * FROM questions WHERE author = ?
    SQL

    Question.convert(results)
  end

  def self.most_liked(n)
    Like.most_liked_questions(n)
  end

  def self.most_followed(n)
    Follow.most_followed_questions(n)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author = options['author']
  end


  def author_name
    User.find_by_id(@author)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    Follow.followers_for_question_id(@id)
  end

  def likers
    Like.likers_for_question_id(@id)
  end

  def num_likes
    Like.num_likes_for_question_id(@id)
  end
end
