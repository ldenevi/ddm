class Trial::SignUpController < Trial::PublicController
  def form
    @user = User.new_trial
  end

  def register_new_user
    redirect_to :action => 'already_registered' if is_domain_already_registered(params[:user][:email])
    user = User.new_trial(params[:user])
    user.save
    render :text => user.errors.inspect
  end

  def already_registered
  end

  def welcome
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
