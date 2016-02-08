require 'adyen_hpp/payment_fields/base'

class AdyenHpp
  class PaymentFields
    class ShopperEmailField < AdyenHpp::PaymentFields::Base
      def convert
        if @value.respond_to? :to_str
          @value.to_str
        else
          fail TypeError, 'invalid type'
        end
      end

      private

      def validate error_aggregator
        return error_aggregator if @value.nil?
        if can_not_convert?
          error_aggregator.add self, 'invalid type'
        end
        error_aggregator
      end
    end
  end
end
