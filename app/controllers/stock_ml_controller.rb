class StockMlController < ApplicationController
    before_action :authenticate_user!
    def index
        offset = params[:offset]
        if offset == nil
            offset = 0 
        end
        seller_id   = "275100710"
        url_base    = "https://api.mercadolibre.com"
        url_final   = "#{url_base}/sites/MLM/search?seller_id=#{seller_id}&offset=#{offset}"

        response = HTTParty.get("#{url_final}")
        

        response_boby = JSON.parse response.body
        paging = response_boby["paging"]

        @offset_anterior    = paging["offset"].to_i - 50
        @offset_siguiente   = paging["offset"].to_i + 50
        @show_btn_prev      = false
        @show_btn_next      = false

        if ((paging["total"].to_i - (offset.to_i + 50 )) > 0 )
            @show_btn_next      = true
        else
            @show_btn_next      = false
        end

        if @offset_anterior < 0
            @show_btn_prev      = false
        else
            @show_btn_prev      = true
        end

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

        if ml_auth.expiration_date < (Time.now + 1.hour)
            puts "actualizando token"
            MlAuth.refrescar_token_ff(ml_auth)
        end

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
        redirect_to items_path
    end

    def test_worker
    end

    def do_test_worker
        quantity = params[:quantity_of_items]
        
        AddRandomItemsMlWorker.perform_async(quantity)

        respond_to do |format|
            format.html { redirect_to stock_ml_test_worker_path, notice: "El worker se está ejecutando" }
            format.json { head :no_content }
        end
    end

    def pause_items_worker
    end

    def pause_all_items
        PauseAllItemsMlWorker.perform_async
        respond_to do |format|
            format.html { redirect_to stock_ml_test_worker_pause_path, notice: "El worker está pausando las publicaciones" }
            format.json { head :no_content }
        end
    end

end
