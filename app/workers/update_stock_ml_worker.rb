class UpdateStockMlWorker
  include Sidekiq::Worker

  def perform()
    puts "================================="
    puts "Inicio worker"
    puts "================================="
    sleep(5.seconds)
    puts "---------------------------------"
    puts "Fin worker"
    puts "---------------------------------"
  end
end
