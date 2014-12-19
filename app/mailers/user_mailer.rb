class UserMailer < ActionMailer::Base
  default from: "test.janek.kurzydlo@gmail.com"

  def signup_confirmation(user)
    @user = user
    mail to: user.email , sublect: "Sign Up confirmation"
  end

  def password_reset(user)
	  @user = user
	  mail :to => user.email, :subject => "Password Reset"
  end

end
