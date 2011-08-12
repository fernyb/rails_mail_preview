require 'rails_mail_preview'
require 'rails'

module RailsMailPreview
  class Railtie < ::Rails::Railtie

    initializer 'rails_mail_preview.insert_into_action_mailer' do
      ActiveSupport.on_load :action_mailer do
        ActionMailer::Base.send :include, RailsMailPreview::Preview::Glue
      end
    end

  end
end
