# $redis = Redis.new(url: ENV["REDIS_URL"], ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })

uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(:url => uri)

if Rails.env == 'production'
  uri = URI.parse(ENV["REDISTOGO_URL"])
  REDIS = Redis.new(:url => uri)
end