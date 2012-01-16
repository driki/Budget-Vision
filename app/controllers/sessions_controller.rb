class SessionsController < ApplicationController
  def login
    if !signed_in?
      session[:pre_login_path] = @_env['HTTP_REFERER']
    end
  end

  def create
    auth = request.env["omniauth.auth"]

    @user = User.find_or_create_by_uid_and_provider({
        :uid => auth["uid"],
        :name => auth["info"]["name"],
        :email => auth["info"]["email"],
        :provider => auth["provider"]})

    self.current_user = @user

    if session[:pre_login_path].nil?
      redirect_to "/"
    else
      redirect_to session[:pre_login_path]
    end
  end

  def destroy
    session.clear
    redirect_to :back
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end