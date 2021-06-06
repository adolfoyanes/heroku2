class AuthMlController < ApplicationController
  def auth_response
    
    #@state   = params[:state]
    code        = params[:code]
    app_id      = ENV["APP_ID"]
    secret_key  = ENV["SCRET_KEY"]
    redirect_uri= ENV["REDIRECT_URL"]

    url_base    = "https://api.mercadolibre.com/oauth/token"
    parametros  = {"grant_type"=> "authorization_code", "client_id"=> "#{app_id}", "client_secret" => "#{secret_key}",  "code" => "#{code}","redirect_uri"=>"#{redirect_uri}" }
    header      = {"Content-Type" => "application/json" , "Accept" => "application/json"}


    #response = HTTParty.post("#{url_final}", :body => parametros.to_json, :headers =>header)

    response = {
      "body" => 
        {
          "access_token": "APP_USR-123456-090515-8cc4448aac10d5105474e1351-1234567",
          "token_type": "bearer",
          "expires_in": 10800,
          "scope": "offline_access read write",
          "user_id":1234567,
          "refresh_token": "TG-5b9032b4e23464aed1f959f-1234567"
        }
    }

    response = response.to_json

    response_boby = JSON.parse(response)

    @grant_type = response_boby["body"]["access_token"]

    d = DateTime.now
    d = d + response_boby["body"]["expires_in"].seconds
    @ml_auth = MlAuth.create(
      token: response_boby["body"]["access_token"],
      refresh_token: response_boby["body"]["refresh_token"],
      expiration_date: d.strftime("%Y-%m-%d %H:%M:%S")
    )
    
  end
end