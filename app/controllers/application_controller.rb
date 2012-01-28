class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :show_welcome

  rescue_from CanCan::AccessDenied do |exception|
    if !signed_in?
      session[:pre_login_path] = @_env['HTTP_REFERER']
      render :file => "#{Rails.root}/public/403.html", :status => 403
    else
      session[:pre_login_path] = @_env['HTTP_REFERER']
      render :file => "#{Rails.root}/public/403_not_a_member.html", :status => 403
    end
  end

  def show_not_verified_alert
    session[:show_project_not_verified] ||= {}
    if !@project.nil? && @project.organization.is_verified
      session[:show_project_not_verified][@project.id] = false
    else
      if session[:show_project_not_verified][@project.id].nil?
        session[:show_project_not_verified][@project.id] = true
      else
        session[:show_project_not_verified][@project.id] = false
      end
    end
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

  def show_welcome
    if session[:show_welcome].nil?
      session[:show_welcome] = true
    else
      session[:show_welcome] = false
    end
  end
end
