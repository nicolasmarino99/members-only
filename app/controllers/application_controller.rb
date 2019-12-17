# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def redirect_back_or(default)
    redirect_to(cookies[:forwarding_url] || default)
    cookies.delete(:forwarding_url)
  end

  def store_location
    cookies[:forwarding_url] = request.original_url if request.get?
  end
end
