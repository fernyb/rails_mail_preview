require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe RailsMailPreview::Preview::Glue do
    before do
      mailer = Class.new do
        class << self
          attr_accessor :delivery_method
        end

        def mail(headers, &block)
          true
        end
      end
      mailer.send(:include, RailsMailPreview::Preview::Glue)

      @mailer = mailer.new
    end

    it "should return true" do
      @mailer.mail("hello").should be_true
    end

    let :message do
      message = Struct.new(:class).new("Mail::Message")
      message.stub(:to_lf).and_return("mail message")
      message.stub(:encoded).and_return(message)
      message
    end

    it "sends postNotificationName" do
      notify = mock("FBDistributedNotification")
      notify.should_receive(:postNotificationName).with("RailsMailPreview.email", object: "mail message")

      notification = FBDistributedNotification.stub(:new).and_return(notify)

      @mailer.stub(:orig_mail).and_return(message)
      @mailer.mail("headers").should be_true
    end

    it "does not sends postNotificationName" do
      FBDistributedNotification.should_not_receive(:new)
      message.stub(:class).and_return("NotMessage")

      @mailer.stub(:orig_mail).and_return(message)
      @mailer.mail("headers").should be_true
    end
end
