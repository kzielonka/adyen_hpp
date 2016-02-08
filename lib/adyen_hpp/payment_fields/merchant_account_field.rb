require 'adyen_hpp/payment_fields/base'

class AdyenHpp
  class PaymentFields
    class MerchantAccountField < AdyenHpp::PaymentFields::Base
      def convert
        case @value
        when String then @value
        else fail TypeError, 'invalid type'
        end
      end

      private

      def validate(errors_aggregator)
        if @value.nil?
          errors_aggregator.add_required_field_error self
        elsif can_not_convert?
          errors_aggregator.add self, 'invalid type'
        end
        errors_aggregator
      end
    end
  end
end
