require 'adyen_hpp/payment_fields/base'
require 'adyen_hpp_hmac_calculator'

class AdyenHpp
  class PaymentFields
    class MerchantSigField < AdyenHpp::PaymentFields::Base
      def convert
        if @value.respond_to? :to_s
          @value.to_s
        else
          fail TypeError, 'invalid type'
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
