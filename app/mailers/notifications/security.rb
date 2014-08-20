class Notifications::Security < ActionMailer::Base
  default from: "welcome@gsp-app.greenstatuspro.com"


  def welcome(user)
    @user = user
    mail :to => user.email, :subject => "Welcome to Green Status Pro!"
  end

  def notify_gsp_of_new_trial_user(user)
    @user = user
    mail :to => "leo.denevi@greenstatuspro.com, john.logan@greenstatuspro.com, rob.kasameyer@greenstatuspro.com, steven.correia@greenstatuspro.com, jack.logan@greenstatuspro.com", :subject => "New trial user signed up"
  end
end
