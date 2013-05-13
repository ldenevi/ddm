class Notifications::Reviews < ActionMailer::Base
  default from: "review@greenstatuspro.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.reviews.deploy.subject
  #
  def deploy
    @greeting = "Hi"

    mail to: "to@example.org"
  end
  
  def task_comment_added
  end
end
