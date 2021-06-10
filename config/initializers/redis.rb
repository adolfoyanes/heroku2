# $redis = Redis.new(url: ENV["REDIS_URL"], ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })

=begin
uri = URI.parse("#{ENV["REDIS_URL"]}/1")
REDIS = Redis.new(:url => uri)

if Rails.env == 'production'
  uri = URI.parse("#{ENV["REDIS_URL"]}/1")
  REDIS = Redis.new(:url => uri)
end
=end

url = URI.parse("redis://:p7094fc34870884a8d8cf8495f2f28d5206cadad3c62f873caba8d00d809bb54e@ec2-3-210-158-128.compute-1.amazonaws.com:30000")
url.scheme = "rediss"
url.port = Integer(url.port)
$redis = Redis.new(url: url, driver: :ruby, ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })