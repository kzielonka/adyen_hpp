require 'adyen_hpp/payment_fields/base'

class AdyenHpp
  class PaymentFields
    class CountryCodeField < AdyenHpp::PaymentFields::Base
      def convert
        if @value.respond_to? :to_s
          @value.to_s.upcase.freeze
        else
          fail TypeError, 'invalid type'
        end
      end

      private

      def validate error_aggregator
        return error_aggregator if @value.nil?
        if can_not_convert?
          error_aggregator.add self, 'invalid type'
        elsif not convert.match(/^[A-Z]{2}$/)
          error_aggregator.add self, 'is not valid country code'
        end
        error_aggregator
      end
    end
  end
end
