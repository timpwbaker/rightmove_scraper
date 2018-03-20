class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate!

  def authenticate!
    return true unless Rails.env == 'production'
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['HTTP_USER'] && password == ENV["HTTP_PASSWORD"]
    end
  end
end
