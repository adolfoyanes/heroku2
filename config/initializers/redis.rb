# $redis = Redis.new(url: ENV["REDIS_URL"], ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })

=begin
uri = URI.parse("#{ENV["REDIS_URL"]}/1")
REDIS = Redis.new(:url => uri)

if Rails.env == 'production'
  uri = URI.parse("#{ENV["REDIS_URL"]}/1")
  REDIS = Redis.new(:url => uri)
end
=end

url = URI.parse(ENV["REDIS_URL"])
url.scheme = "rediss"
url.port = Integer(url.port) + 1
$redis = Redis.new(url: url, driver: :ruby, ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })