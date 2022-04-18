class CrearItemWorker
  include Sidekiq::Worker
  # include Sidekiq::Status::Worker # enables job status tracking


  def expiration
    @expiration ||= 60 * 60 * 24 * 30 # 30 days
  end

  
  def perform( seller_id, params, informe_id)
    # Do something later
    inicio = Time.now()
    
    items = Item.where("visible" => true)
    items.each do |x|
      puts "El item #{x.title} tiene id #{id}"
    end

  
    puts "total time:"
    puts Time.now() - inicio 
  end ## cierra metodo 
end