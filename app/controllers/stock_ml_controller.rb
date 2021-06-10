class StockMlController < ApplicationController
    before_action :authenticate_user!
    def index
        seller_id   = "275100710"
        url_base    = "https://api.mercadolibre.com"
        url_final   = "#{url_base}/sites/MLM/search?seller_id=#{seller_id}"

        response = HTTParty.get("#{url_final}")

        response_boby = JSON.parse response.body

        @items = response_boby['results']
    end

    def edit
        id = params[:id]

        url_base    = "https://api.mercadolibre.com"
        url_final   = "#{url_base}/items/#{id}"

        response_boby = HTTParty.get("#{url_final}")

        #@item = JSON.parse response.body
        @item = Item.new
        @item.id = id
        @item.title = response_boby["title"]
        @item.description = response_boby["descripction"]
        @item.available_quantity = response_boby["available_quantity"] 
        #puts response_boby
    end

    def update
        ml_auth = MlAuth.first

        #if ml_auth.expiration_date < (Time.now + 1.hour)
            puts "actualizando token"
            MlAuth.refrescar_token_ff(ml_auth)
        #end

        id          = params[:id]
        url_base    = "https://api.mercadolibre.com"
        url_final   = "#{url_base}/items/#{id}"
        header      = {"Content-Type" => "application/json" , "Accept" => "application/json" ,"Authorization" => "Bearer #{ml_auth.token}"}
        parametros  = {
            "title" => params[:title],
            "available_quantity" => params[:available_quantity],
        }
        response = HTTParty.put("#{url_final}", body: parametros.to_json, :headers => header)

        redirect_to stock_ml_path
    end
    
    def sink_up
        UpdateStockMlWorker.perform_async
        #Item.all.each{ |item|
        #    update_item_ml(item)
        #}
        redirect_to items_path
    end

    private
    def update_item_ml(item)
        
    end
end
