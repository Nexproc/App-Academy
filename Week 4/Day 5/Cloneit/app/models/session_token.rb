class SessionToken < ActiveRecord::Base
  validates :user, :value, presence: true

  belongs_to :user

  def self.new_token(user)
    token = SessionToken.new(user_id: user.id)
    token.value = SecureRandom.urlsafe_base64
    token
  end

end
