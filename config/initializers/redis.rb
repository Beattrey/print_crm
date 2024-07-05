Redis.current = Redis.new(url: ENV['REDIS_URL'] || Rails.application.credentials.dig(:redis_url))
