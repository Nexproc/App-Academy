class User < ActiveRecord::Base
  after_initialize :ensure_has_token
  validates :email, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: true

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def reset_token!
    self.session_token = SecureRandom.urlsafe_base64
  end

  def ensure_has_token
    session_token || reset_token!
  end

  def password=(pass)
    self.password_digest = BCrypt::Password.create(pass)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
end
