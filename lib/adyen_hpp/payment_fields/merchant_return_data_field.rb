require 'adyen_hpp/payment_fields/base'

class AdyenHpp
  class PaymentFields
    class MerchantReturnDataField < AdyenHpp::PaymentFields::Base
      def convert
        if @value.respond_to? :to_str
          @value.to_str
        else
          fail TypeError, 'invalid type'
        end
      end

      private

      def validate(errors_aggregator)
        return errors_aggregator if @value.nil?
        if can_not_convert?
          errors_aggregator.add self, 'invalid type'
        elsif convert.size > 128
          errors_aggregator.add self, 'can not be longer then 128 characters'
        end
        errors_aggregator
      end
    end
  end
end
