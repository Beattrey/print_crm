require 'sidekiq'
require 'sidekiq/web'
require 'sidekiq-scheduler'
require 'sidekiq-scheduler/web'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] || Rails.application.credentials.dig(:redis_url) }

  if Rails.env.production?
    config.on(:startup) do
      SidekiqScheduler::Scheduler.instance.rufus_scheduler_options = { max_work_threads: 1 }
      Sidekiq.schedule = YAML.load_file(File.join(Rails.root, 'config/sidekiq_scheduler.yml'))[Rails.env]
      SidekiqScheduler::Scheduler.instance.reload_schedule!
    end
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] || Rails.application.credentials.dig(:redis_url)  }
end
