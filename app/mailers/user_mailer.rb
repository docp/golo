class UserMailer < ActionMailer::Base
  default :from => "not@forungood.go"

  def welcome_mail(name, email)
    @user = name
    mail(:to => email,
         :subject => "Welcome at Golo")
  end

  # method implemented just for testing
  def test_mail(name, email)
#    format.text
    @user = name
    mail(:to => email,
         :subject => "Second Test")
  end
end

