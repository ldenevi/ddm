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

  def deploy(review)
    coordinator = review.responsible_party
    delegates   = review.tasks.collect(&:reviewer).uniq
    subject     = "New review available [due #{review.targeted_completion_at.strftime("%b %d, %Y")}]"
    @review     = review
    mail :to => [coordinator.email, delegates.collect(&:email)].flatten.uniq, :subject => subject
  end
end
