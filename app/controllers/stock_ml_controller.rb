class StockMlController < ApplicationController
    def sink_up
        Item.all.each{ |item|
            update_item_ml(item)
        }
        redirect_to items_path
    end

    private
    def update_item_ml(item)
        acces_token = MlAuth.first

        url_base    = "https://api.mercadolibre.com/items"
        header      = {"Content-Type" => "application/json" , "Accept" => "application/json" ,"Authorization" => "Bearer #{acces_token.token}"}
        parametros  = {
            "site_id" => "MLA",
            "title"=> item.title,
            "category_id"=> "MLA1577",
            "price"=> 4000,
            "currency_id"=> "ARS",
           "pictures" => [
                 {
                   "source"=> "http://mla-s2-p.mlstatic.com/777099-MLA26466460545_112017-O.jpg"   
                }
            ],
            "buying_mode" => "buy_it_now",
            "listing_type_id" => "gold_special",
            "condition" => "new",
            "available_quantity" => item.available_quantity,
            "sale_terms" => [
              {
                "id" => "MANUFACTURING_TIME",
                "value_name" => "20 días"
              } 
           ]
        }
        response = HTTParty.post("#{url_base}", body: parametros.to_json, :headers => header)

        response_boby = JSON.parse response.body

        #SI EL TOKEN ES INVÁLIDO ENTONCES SE ACTUALIZA
        if response_boby["message"] == "Invalid token"

            #SE ACTUALIZA EL ACCES TOKEN SI YA CADUCÓ
            code        = acces_token.refresh_token
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

            #SE ACTUALIZA EL REGISTRO DE LA BASE DE DATOS
            acces_token.token = response_boby["access_token"],
            acces_token.refresh_token = response_boby["refresh_token"],
            acces_token.expiration_date = d.strftime("%Y-%m-%d %H:%M:%S")

            acces_token.save

            #SE VUELVE A HACER EL INTENTO DE ACTUALIZAR STOCK
            response = HTTParty.post("#{url_base}", body: parametros.to_json, :headers => header)
            response_boby = JSON.parse response.body
        end

        puts "-------------------------------------"
        puts response_boby["message"]
        puts "-------------------------------------"

        
        ml_id = "id_ml_#{item.id}"
        #ml_id = response_boby["ml_id"]
        MlListing.create(
            ml_id:ml_id,
            item_id: item.id
        )
    end
end
