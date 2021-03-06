class User < ActiveRecord::Base
  validates :email, :session_token, uniqueness: true

  attr_reader :password
  after_initialize :ensure_session_token


  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def self.reset_session_token
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token

  end

  def self.find_by_credentials(email,password)
    user = User.find_by_email(email)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Pasword.new(self.password_digest).is_password?(password)
  end



end
