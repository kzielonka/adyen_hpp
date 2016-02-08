require 'adyen_hpp/payment_fields/base'

class AdyenHpp
  class PaymentFields
    class ShopperStatementField < AdyenHpp::PaymentFields::Base
      def convert
        return nil if @value.nil?
        String(@value)
      end

      private

      def validate errors_aggregator
        return errors_aggregator if @value.nil?
        if can_not_convert?
          errors_aggregator.add self, 'invalid type'
        elsif convert.size > 135
          errors_aggregator.add self, 'can not be longer then 135 characters'
        elsif !convert.match(/\A[a-zA-Z0-9.,\-?|]*\z/)
          errors_aggregator.add self, 'has invalid character'
        end
        errors_aggregator
      end
    end
  end
end
