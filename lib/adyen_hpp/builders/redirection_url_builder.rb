require 'uri'

class AdyenHpp
  module Builders
    class RedirectionUrlBuilder
      Config = Struct.new(:adyen_url)
      DEFAULT_ADYEN_URL = 'http://adyen.com'

      def initialize(config)
        @params = []
        @config = config
      end

      attr_reader :config

      def add_field(name, value)
        @params << [name, value]
      end

      def build
        uri = URI.parse(@config.adyen_url)
        uri.query = encode_params
        uri.to_s
      end

      def self.new_config
        Config.new(DEFAULT_ADYEN_URL)
      end

      private

      def encode_params
        URI.encode_www_form(@params)
      end
    end
  end
end
