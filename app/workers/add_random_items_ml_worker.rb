class AddRandomItemsMlWorker
  include Sidekiq::Worker

  def perform(num_items)
    puts "Ejecutando worker ------------------------"
    #Se crean N número de items
    #create_items(num_items)
    puts "Creando items #{num_items}"
    i = 0
    while i < num_items
      puts "Hola mundo"
      i = i + 1
    end
    #for i in(1..num_items)
      #puts i
      #Item.create(
       # title: "Item test #{i} No Comprar",
       # description: "Item descripction #{i}",
       # barcode: "ABC#{i}",
       # available_quantity: i,
       # visible: true,
       # seller_id: 1
      #)
    #end

    puts "Termina de crear items"
    #Se sincroniza con ML

    #sink_up_to_ml()
    puts "Termina worker ------------------------"
  end

  private 
  def create_items(num_items)
    puts "Creando items"
    for i in(1..num_items)
      puts i
      #Item.create(
       # title: "Item test #{i} No Comprar",
       # description: "Item descripction #{i}",
       # barcode: "ABC#{i}",
       # available_quantity: i,
       # visible: true,
       # seller_id: 1
      #)
    end

    puts "Termina de crear items"
  end

  def sink_up_to_ml
    puts "Actualizando items en base de datos"
    items = Item.where(synchronized_ml: false,update_in_process: false)

    items.each{ |item|
      ml_auth = MlAuth.first
      
      if ml_auth.expiration_date < (Time.now + 1.hour)
        MlAuth.refrescar_token_ff(ml_auth)
      end

      item.update_in_process = true;
      url_base    = "https://api.mercadolibre.com/items"
      header      = {"Content-Type" => "application/json" , "Accept" => "application/json" ,"Authorization" => "Bearer #{ml_auth.token}"}
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

      if response.code == 200
        item.update_in_process  = false
        item.synchronized_ml    = true
        item.save
      else
        item.update_in_process  = false
        item.save
      end
      item.save
      ml_id = response_boby["id"]
      MlListing.create(
          ml_id:ml_id,
          item_id: item.id
      )
    }
  end
end
