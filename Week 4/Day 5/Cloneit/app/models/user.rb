class User < ActiveRecord::Base
  attr_reader :password
  validates :username, :email, :password_digest, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :session_tokens, dependent: :destroy
  has_many :comments

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return user unless user #exists
    user.is_password?(password) ? user : nil
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
