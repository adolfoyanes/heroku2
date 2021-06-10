url = URI.parse("redis://:p7094fc34870884a8d8cf8495f2f28d5206cadad3c62f873caba8d00d809bb54e@ec2-3-210-158-128.compute-1.amazonaws.com:30000")
url.scheme = "rediss"
url.port = Integer(url.port) + 1

Sidekiq.configure_server do |config|
    config.redis = { url: url.to_s }
end

Sidekiq.configure_client do |config|
    config.redis = { url: url.to_s }
end