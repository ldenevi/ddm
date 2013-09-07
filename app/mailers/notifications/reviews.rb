class Notifications::Reviews < ActionMailer::Base
  default :from => "review@greenstatuspro.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.reviews.deploy.subject
  #
  def deploy_test(review)
    @greeting = "E-Mail test"
    mail :to => "leo.denevi@greenstatuspro.com", :subject => "[TEST] Review #{review.name} deployed" #email
  end
  
  def task_comment_added
  end
end
