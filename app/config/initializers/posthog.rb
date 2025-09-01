# frozen_string_literal: true

# require 'posthog'

# POSTHOG_API_KEY = ENV.fetch('POSTHOG_API_KEY', nil)

# if Rails.env.production? && POSTHOG_API_KEY.blank?
#   msg = 'Please set the POSTHOG_API_KEY env var'

#   Rails.logger.fatal msg
#   raise msg
# end

# if POSTHOG_API_KEY.present? && !Rails.env.test?
#   Rails.logger.info 'PostHog configured'

#   POSTHOG = PostHog::Client.new({
#     api_key: POSTHOG_API_KEY,
#     host: 'https://eu.i.posthog.com',
#     on_error: proc { |_status, msg| Rails.logger.error "PostHog error: #{msg}" }
#   })
# else
#   POSTHOG = nil
# end
