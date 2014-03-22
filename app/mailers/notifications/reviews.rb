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

  def deploy(review)
    coordinator = review.responsible_party
    delegates   = review.tasks.collect(&:reviewer).uniq
    subject     = "New review available [due #{review.targeted_completion_at.strftime("%b %d, %Y")}]"
    @review     = review
    mail :to => [coordinator.email, delegates.collect(&:email)].flatten.uniq, :subject => subject
  end

  def task_closed(task, closer)
    @task   = task
    emails  = [task.reviewer.email, task.review.responsible_party.email].uniq
    subject = "[#{task.status}] Task '#{task.name}' closed by #{closer.eponym}"
    mail :to => emails, :subject => subject
  end

  def task_reopened(task, opener)
    @task   = task
    emails  = [task.reviewer.email, task.review.responsible_party.email].uniq
    subject = "Task '#{task.name}' reopened by #{opener.eponym}"
    mail :to => emails, :subject => subject
  end

  def task_comment_posted(comment, poster)
    @task   = comment.commentable
    @poster = poster
    emails  = [comment.author.email, @task.reviewer.email, @task.review.responsible_party.email].uniq
    subject = "Comment posted to '#{@task.name}' by #{poster.eponym}"
    mail :to => emails, :subject => subject
  end
end
