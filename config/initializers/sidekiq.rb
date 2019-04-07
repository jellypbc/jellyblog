module Sidekiq
  class JobDurationMiddleware
    def call(worker, job, queue)
      record_duration job do
        yield
      end
    end

    private

      def record_duration(job, &blk)
        start_time = Time.now

        yield

        duration_in_ms = (Time.now - start_time) * 1000

        log job, duration_in_ms
      end


      def log(job, duration_in_ms)
        Sidekiq.logger.info "queue=#{job['queue']} class=#{job['class']} enqueued_at=#{job['enqueued_at']} ran_at=#{Time.now.to_f} duration=#{duration_in_ms}ms"
      end
  end
end


Sidekiq.configure_server do |config|
  if Rails.env.development?
    config.redis = {
      size: 12,
      port: (6379 + ENV["PORT_INCREMENT"].to_i)
    }
  else
    config.redis = { size: 12 }
  end

  config.server_middleware do |chain|
    chain.add Sidekiq::JobDurationMiddleware
  end

  # schedule_file = "config/schedule.yml"
  # if File.exists?(schedule_file)
  #   Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  # end
end

Sidekiq.configure_client do |config|
  if Rails.env.development?
    config.redis = {
      size: 3,
      port: (6379 + ENV["PORT_INCREMENT"].to_i)
    }
  else
    config.redis = { size: 3 }
  end
end

# Don't include delay extensions
# Sidekiq.remove_delay!