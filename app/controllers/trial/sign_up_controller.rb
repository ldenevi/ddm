class Trial::SignUpController < Trial::PublicController
  def form
    @user = Trial::TrialUser.new
  end

  def register_new_user
    if is_domain_already_registered(params[:trial_trial_user][:email])
      redirect_to :action => 'already_registered'
    else
      @user = Trial::TrialUser.new(params[:trial_trial_user])

      if @user.save
        redirect_to :action => :welcome
      else
        flash[:errors] = @user.errors
        redirect_to :back
      end
    end
  end

  def already_registered
  end

  def welcome
    unless request.referer.to_s.match("register_new_user")
      redirect_to :action => :form
    end
  end

  def setup_organizations
  end

  def setup_users
  end

private
  def is_domain_already_registered(email)
    !User.where("email LIKE ?", "%@#{email.split("@").last}").empty?
  end
end
