class Trial::SignUpController < Trial::PublicController
  layout "application"

  def index
  end

  def new_password
    @email = params[:email]
    @user  = Trial::TrialUser.new :email => params[:email], :password => params[:password]
  end

  def form
    @user = Trial::TrialUser.new
  end

  def register_new_user
    @user = Trial::TrialUser.new(params[:trial_trial_user])

    if @user.save
      sign_in @user
      Notifications::Security.welcome(@user).deliver
      redirect_to root_url
    else
      flash[:errors] = @user.errors
      redirect_to :action => :already_registered
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

end
