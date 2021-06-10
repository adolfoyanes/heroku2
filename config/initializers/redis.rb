url_redis = ENV["REDIS_URL"] || "redis://127.0.0.1:6379"
uri = URI.parse(url_redis)
REDIS = Redis.new(url: uri, driver: :ruby, ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })