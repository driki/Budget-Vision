class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :record_pre_login_path

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/403.html", :status => 403
  end

  def remote_ip
    remote_ip = nil
    if request.remote_ip == '127.0.0.1'
      # Hard coded remote address
      remote_ip = '146.115.184.188'
    else
      remote_ip = request.remote_ip
    end
    return remote_ip
  end

  protected

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !session[:user_id].nil?
  end

  helper_method :current_user, :signed_in?

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def record_pre_login_path
    if !signed_in?
      session[:pre_login_path] = @_env['REQUEST_URI']
    end
  end
end
