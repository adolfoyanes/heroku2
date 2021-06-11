class NotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    abort("Message goes here")
  end
end
