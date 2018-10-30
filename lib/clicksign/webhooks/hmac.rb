module Clicksign
  module Webhooks
    class HMAC < Struct.new(:request)
      def validate!
        raise InvalidHMACError unless valid?
      end

      def valid?
        hmac_header.include?(hmac)
      end

      def digest
        @digest = OpenSSL::Digest::SHA256.new
      end

      def data
        @data = request.body.read
      end

      def hmac
        @hmac = OpenSSL::HMAC.hexdigest(digest, ENV['CLICKSIGN_HMAC_KEY'], data)
      end

      def hmac_header
        @hmac_header = request.headers['Content-Hmac'] || ''
      end
    end

    class InvalidHMACError < StandardError
    end
  end
end
