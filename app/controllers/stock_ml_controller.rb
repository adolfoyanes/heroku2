class StockMlController < ApplicationController
    def index
        acces_token = MlAuth.first
        seller_id   = "275100710"
        url_base    = "https://api.mercadolibre.com"
        url_final    = "#{url_base}/sites/MLM/search?seller_id=#{seller_id}"

        response = HTTParty.get("#{url_final}")

        response_boby = JSON.parse response.body

        @items = response_boby['results']
    end
    
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
            "site_id" => "MLM",
            "title"=> item.title,
            "category_id"=> "MLM422401",
            "price"=> 4000,
            "currency_id"=> "MXN",
            "pictures" => [
                {
                "source"=> "http://mla-s2-p.mlstatic.com/777099-MLA26466460545_112017-O.jpg"   
                }
            ],
            "description"=>{
            "plain_text"=>"Descripción con Texto Plano \n"
            },
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

        puts "-------------------------------------"
        puts response_boby
        puts "-------------------------------------"

        
        ml_id = "id_ml_#{item.id}"
        #ml_id = response_boby["ml_id"]
        MlListing.create(
            ml_id:ml_id,
            item_id: item.id
        )
    end
end
