# frozen_string_literal: true

if Rails.env.development?
  class ViteRuby
    def dev_server_running?
      true
    end
  end
end
