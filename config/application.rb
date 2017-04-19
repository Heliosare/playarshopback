require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Playars
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('lib')
    config.action_mailer.delivery_method = :sendmail
    # Defaults to:
    # config.action_mailer.sendmail_settings = {
    #   location: '/usr/sbin/sendmail',
    #   arguments: '-i -t'
    # }
    config.action_mailer.smtp_settings = {
      address:              'smtp.zoho.com',
      port:                 465,
      domain:               'playarshop.com',
      user_name:            'vincent.galoger@gmail.com',
      password:             'deployermdp42',
      authentication:       'plain',
      enable_starttls_auto: true }
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.default_options = {from: 'contact@playarshop.com'}
    config.action_mailer.default_url_options = { host: 'example.com' }
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
  end
end
