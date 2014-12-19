class User < ActiveRecord::Base
	has_secure_password
  has_many :orders, dependent: :destroy
  mount_uploader :avatar, AvatarUploader


  validates_presence_of :email, :message => "Proszę podać e-mail."
  validates_presence_of :nick, :message => "Prosze podać nazwę użytkownika."
  validates_uniqueness_of :email, :nick
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }

  before_create { generate_token(:auth_token) }

  def generate_token(column)
	  begin
	    self[column] = SecureRandom.urlsafe_base64
	  end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!

    UserMailer.password_reset(self).deliver
  end

  def confirm
    self.confirmed = true
    save!
  end

  def is_admin?
    self.admin
  end

end
