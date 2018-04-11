class User < ApplicationRecord
  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, uniqueness: true

  attr_reader :password

  after_initialize :ensure_session_token


  has_many :cats,
    class_name: "Cat",
    foreign_key: :user_id,
    primary_key: :id

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    possible_password = BCrypt::Password.new(self.password_digest)
    possible_password.is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    return user if user && user.is_password?(password)
  end



end
