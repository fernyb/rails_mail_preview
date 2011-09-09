require 'action_view'
require 'active_support/concern'

module RailsMailPreview
  module Preview
    module Glue
      extend ActiveSupport::Concern

      included do |sender|
        sender.class_eval do
          alias_method :orig_mail, :mail
          def mail(headers, &block)
            m = orig_mail(headers, &block)
            if m.class.to_s == "Mail::Message"
              notification = ::FBDistributedNotification.new
              notification.postNotificationName("RailsMailPreview.email", object: m.encoded.to_lf)
            end
            m
          end
        end
      end

    end # Glue
  end # Preview
end
