class NotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    
    puts "---------------------------"
    puts "Saving notification"
    puts "---------------------------"
    Notification.create(
      resource: params[:resource],
      user_id: params[:user_id],
      topic: params[:topic],
      application_id: params[:application_id],
      attempts: params[:attempts],
      sent: params[:sent],
      received: params[:received]
    )
    render status: 200, json: "Ok"
  end
end
