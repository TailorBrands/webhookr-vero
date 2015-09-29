require "webhookr"
require "webhookr-vero/version"
require "webhookr/ostruct_utils"

module Webhookr
  module Vero
    class Adapter
      SERVICE_NAME = "vero"
      EVENT_KEY = "type"
      USER_KEY = "user"

      include Webhookr::Services::Adapter::Base

      def self.process(raw_response)
        new.process(raw_response)
      end

      def process(raw_response)
        Array.wrap(parse(raw_response)).collect do |p|
          Webhookr::AdapterResponse.new(
            SERVICE_NAME,
            p.fetch(EVENT_KEY),
            OstructUtils.to_ostruct(p.except(EVENT_KEY))
          ) if assert_valid_packet(p)
        end
      end

      private

      def parse(raw_response)
        begin
          ActiveSupport::JSON.decode(
            CGI.unescape(raw_response)
          )
        rescue Exception => e
          raise InvalidPayloadError.new(e)
        end
      end

      def assert_valid_packet(packet)
        raise(Webhookr::InvalidPayloadError, "Unknown event #{packet[EVENT_KEY]}") unless packet[EVENT_KEY]
        raise(Webhookr::InvalidPayloadError, "No user data in the response") unless packet[USER_KEY] 
        true
      end

    end
  end
end
