# $redis = Redis.new(url: ENV["REDIS_URL"], ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })


uri = URI.parse(ENV["REDIS_URL"])
REDIS = Redis.new(:url => uri,ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })

#if Rails.env == 'production'
#  uri = URI.parse(ENV["REDIS_URL"])
#  REDIS = Redis.new(:url => uri)
#end


#url = "redis://:p7094fc34870884a8d8cf8495f2f28d5206cadad3c62f873caba8d00d809bb54e@ec2-3-210-158-128.compute-1.amazonaws.com:30000"
#url.scheme = "rediss"
#$redis = Redis.new(url: ENV["REDIS_URL"], ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })