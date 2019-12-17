# frozen_string_literal: true

module SessionsHelper
  def sign_in(user)
    remember_token = User.new_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_digest, Digest::SHA1.hexdigest(remember_token))
  end

  def current_user
    cookies_token = Digest::SHA1.hexdigest(cookies.permanent[:remember_token]) if cookies.permanent[:remember_token]
    @current_user ||= User.find_by(remember_digest: cookies_token) if cookies_token
  end

  def log_out
    cookies.delete(:remember_token)
  end

  def current_user?(user)
    user == @current_user
  end

  def logged_in?
    !current_user.nil?
  end
end
