class AuthMlController < ApplicationController
  def auth_response

    code        = params[:code]
    app_id      = ENV["APP_ID"]
    secret_key  = ENV["SECRET_KEY"]
    redirect_uri= ENV["REDIRECT_URL"]

    url_base    = "https://api.mercadolibre.com/oauth/token"
    parametros  = {"grant_type"=> "authorization_code", "client_id"=> "#{app_id}", "client_secret" => "#{secret_key}",  "code" => "#{code}","redirect_uri"=>"#{redirect_uri}" }
    header      = {"Content-Type" => "application/json" , "Accept" => "application/json"}


    response = HTTParty.post("#{url_base}", body: parametros.to_json, :headers => header)

    response_boby = JSON.parse response.body


    d = DateTime.now
    d = d + response_boby["expires_in"].seconds
    MlAuth.create(
      token: response_boby["access_token"],
      refresh_token: response_boby["refresh_token"],
      expiration_date: d.strftime("%Y-%m-%d %H:%M:%S")
    )
      
    
  end
end