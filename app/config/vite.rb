# frozen_string_literal: true

if Rails.env.development?
  class ViteRuby::Config
    def domain
      ENV.fetch('DOMAIN', 'lvh.me')
    end

    def host
      "app.#{domain}"
    end

    def asset_host
      "app.#{domain}"
    end
  end
end
