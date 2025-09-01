# frozen_string_literal: true

Rails.application.configure do
  config.active_job.queue_adapter = :good_job

  # Configure options individually...
  config.good_job.inline_execution_respects_schedule = true
  config.good_job.preserve_job_records = true
  config.good_job.retry_on_unhandled_error = false
  config.good_job.queues = '*'
  config.good_job.enable_cron = true
  config.good_job.dashboard_default_locale = :en

  config.good_job.on_thread_error = lambda { |exception|
    Rails.error.report(exception)
  }

  config.good_job.queues = '*'
  if Rails.env.production?
    config.good_job.execution_mode = :external
    config.good_job.shutdown_timeout = 30 # seconds
  else
    config.good_job.execution_mode = :async
    config.good_job.max_threads = 3
    # config.good_job.max_threads = 1
    config.good_job.shutdown_timeout = 2 # seconds
  end
end
