### crear un producto

item = Item.first
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


### modificar un producto 


### get un producto 


### traer todos los productos (revisar si existe recurso)
