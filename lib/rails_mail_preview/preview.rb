require 'action_view'
require 'active_support/concern'

module RailsMailPreview
  module Preview
    module Glue
      extend ActiveSupport::Concern

      included do |sender|
        if sender.respond_to?("#{self.delivery_method}_intercept_setup")
          sender.send("#{self.delivery_method}_intercept_setup")
        end
      end

      module ClassMethods
        def smtp_intercept_setup
          Net::SMTP.class_eval do
            alias_method :orig_data, :data
            def data(msgstr=nil, &block)
              notification = FBDistributedNotification.new
              notification.postNotificationName("RailsMailPreview.email", object: mail.encoded.to_lf)
              # orig_data(msgstr, &block)
            end
          end
        end

        def sendmail_intercept_setup
          Mail::Sendmail.class_eval do
            class << self
              alias_method :orig_call, :call
              def call(path, arguments, destinations, mail)
                notification = FBDistributedNotification.new
                notification.postNotificationName("RailsMailPreview.email", object: mail.encoded.to_lf)
                #orig_call(ath, arguments, destinations, mail)
              end
            end
          end
        end
      end # => ClassMethods

    end # Glue
  end # Preview
end 
