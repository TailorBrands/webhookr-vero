
$: << File.join(File.dirname(__FILE__), "..")
require 'test_helper'

describe Webhookr::Vero::Adapter do

  before do
    @event_type = "sent"
  end

  def valid_response
    '{
      "type": "sent",
      "user": {
          "id": 12345,
          "email": "kevin@tailorbrands.com"
      },
      "campaign": {
          "id": 1235666234572456,
          "type": "transactional",
          "name": "Cart Abandonment Followup",
          "subject": "You have items in your shopping bag",
          "trigger-event": "Abandoned cart",
          "permalink": "http://app.getvero.com/view/1/9c8c3ac6ac65736926a6da5aefbf852d"
       },
       "sent_at": 1435016238,
       "user_agent":"Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)"
  }'
  end

  def no_user_response
    '{
      "type": "sent",
      "campaign": {
          "id": 1235666234572456,
          "type": "transactional",
          "name": "Cart Abandonment Followup",
          "subject": "You have items in your shopping bag",
          "trigger-event": "Abandoned cart",
          "permalink": "http://app.getvero.com/view/1/9c8c3ac6ac65736926a6da5aefbf852d"
       },
       "sent_at": 1435016238,
       "user_agent":"Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)"
  }'
  end

  describe "the class" do

    subject { Webhookr::Vero::Adapter }

    it "must support process" do
      subject.must_respond_to(:process)
    end

    it "should not return an error for a valid packet" do
      lambda {
        subject.process(valid_response)
      }.must_be_silent
    end

  end

  describe "the instance" do

    subject { Webhookr::Vero::Adapter.new }

    it "should not return an error for a valid packet" do
      lambda {
        subject.process(valid_response)
      }.must_be_silent
    end

    it "should raise Webhookr::InvalidPayloadError for no packet" do
      lambda {
        subject.process("")
      }.must_raise(Webhookr::InvalidPayloadError)
    end

    it "should raise Webhookr::InvalidPayloadError for a missing user" do
      lambda {
        subject.process(no_user_response)
      }.must_raise(Webhookr::InvalidPayloadError)
    end

  end

  describe "it's response" do
    before do
      @adapter = Webhookr::Vero::Adapter.new
    end

    subject { @adapter.process(valid_response).first }

    it "must respond to service_name" do
      subject.must_respond_to(:service_name)
    end

    it "should return the correct service name" do
      assert_equal(Webhookr::Vero::Adapter::SERVICE_NAME, subject.service_name)
    end

    it "must respond to event_type" do
      subject.must_respond_to(:event_type)
    end

    it "should return the correct event type" do
      assert_equal(@event_type, subject.event_type)
    end

    it "must respond to payload" do
      subject.must_respond_to(:payload)
    end

    it "must respond to payload.sent_at" do
      subject.payload.must_respond_to(:sent_at)
    end

    it "should return the correct data packet for sent_at" do
      assert_equal(1435016238, subject.payload.sent_at)
    end

    it "must respond to payload.user_agent" do
      subject.payload.must_respond_to(:user_agent)
    end

    it "should return the correct data packet for user_agent" do
      assert_equal("Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)", subject.payload.user_agent)
    end

    it "must respond to payload.campaign" do
      subject.payload.must_respond_to(:campaign)
    end

    it "should return the correct type for campaign" do
      assert_equal("transactional", subject.payload.campaign.type)
    end

    it "must respond to payload.user" do
      subject.payload.must_respond_to(:user)
    end

    it "should return the correct email for user" do
      assert_equal("kevin@tailorbrands.com", subject.payload.user.email)
    end

  end

end
