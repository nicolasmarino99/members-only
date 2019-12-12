# frozen_string_literal: true

module SessionsHelper
  def remember
    @remember_token = User.new_token
    update_attribute(:remember_token, Digest::SHA1.hexdigest(@remember_token))
  end
  
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user?(user)
    user == current_user
  end

  def current_user
    if user
      cookies.permanent.signed[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
