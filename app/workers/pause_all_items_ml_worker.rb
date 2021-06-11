class PauseAllItemsMlWorker
  include Sidekiq::Worker

  def perform()
    MlListing.all.each{ |mlList|
      ml_auth = MlAuth.first
      
      if ml_auth.expiration_date < (Time.now + 1.hour)
          MlAuth.refrescar_token_ff(ml_auth)
      end

      id          = mlList.ml_id
      url_base    = "https://api.mercadolibre.com"
      url_final   = "#{url_base}/items/#{id}"
      header      = {"Content-Type" => "application/json" , "Accept" => "application/json" ,"Authorization" => "Bearer #{ml_auth.token}"}
      parametros  = {
        "status" => "paused"
      }
      response = HTTParty.put("#{url_final}", body: parametros.to_json, :headers => header)

      mlList.destroy
    }
  end
end
