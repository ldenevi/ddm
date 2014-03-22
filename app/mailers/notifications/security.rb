class Notifications::Security < ActionMailer::Base
  default from: "welcome@gsp-app.greenstatuspro.com"


  def welcome(user)
    @user = user
    mail :to => user.email, :subject => "Welcome to Green Status Pro!"
  end
end
