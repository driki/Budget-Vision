class SessionsController < ApplicationController
  def login

  end

  def create
    auth = request.env["omniauth.auth"]

    @user = User.find_or_create_by_uid_and_provider({
        :uid => auth["uid"],
        :name => auth["info"]["name"],
        :email => auth["info"]["email"],
        :provider => auth["provider"]})

    self.current_user = @user
    redirect_to '/'
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