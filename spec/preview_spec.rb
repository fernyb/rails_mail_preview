require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'net/smtp'

describe RailsMailPreview::Preview::Glue do
  describe "ClassMethods" do
    before do
      mailer = Class.new do
        class << self
          attr_accessor :delivery_method
        end
        include RailsMailPreview::Preview::Glue
      end
      @mailer = mailer.new
    end 

    it "responds to smtp_intercept_setup" do
      @mailer.class.should respond_to(:smtp_intercept_setup)
    end

    it "responds to sendmail_intercept_setup" do
      @mailer.class.should respond_to(:sendmail_intercept_setup)
    end
  end

  describe "*_intercept_setup" do
    before do
      @mailerClass = Class.new do
        class << self
          attr_accessor :delivery_method
        end
      end
    end

    it "should call smtp_intercept_setup" do
      @mailerClass.delivery_method = :smtp
      @mailerClass.should_receive(:smtp_intercept_setup)
      @mailerClass.class_eval do
        include RailsMailPreview::Preview::Glue
      end
    end

    it "should call sendmail_intercept_setup" do
      @mailerClass.delivery_method = :sendmail
      @mailerClass.should_receive(:sendmail_intercept_setup)
      @mailerClass.class_eval do
        include RailsMailPreview::Preview::Glue
      end
    end
  end
end
