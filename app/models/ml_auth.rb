class MlAuth < ApplicationRecord
    def self.refrescar_token_ff(ml_auth)
        url_base  = 'https://api.mercadolibre.com/oauth/token'
        header    = {"Content-Type" => "application/json" , "Accept" => "application/json"}
        parametros = {
                  "grant_type" => 'refresh_token', 
                  "client_id" => ENV["APP_ID"], 
                  "client_secret" => ENV["SECRET_KEY"], 
                  "refresh_token" => ml_auth.refresh_token
                }
        response = HTTParty.post("#{url_base}", :query => parametros, :headers =>header)
        if response.code == 200
          res = JSON.parse response.body
          ml_auth.token = res["access_token"]
          ml_auth.expiration = Time.now + res["expires_in"]
          if ml_auth.save
            return 200
          else
            return 304
            puts "Completed 500 al guardar token de mercadolibre"
          end
        else
          puts "Completed 500 al refrescar token de mercadolibre"
          return 404
        end
    end
end
