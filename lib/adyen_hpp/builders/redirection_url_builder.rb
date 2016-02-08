require 'uri'

class AdyenHpp
  module Builders
    class RedirectionUrlBuilder
      def initialize
        @params = []
      end

      def add_field(name, value)
        @params << [name, value]
      end

      def build
        URI::HTTP.build(
          host: 'adyen.com',
          path: '/asfas',
          query: encode_params
        ).to_s
      end

      private

      def encode_params
        URI.encode_www_form(@params)
      end
    end
  end
end
