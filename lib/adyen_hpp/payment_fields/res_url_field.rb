require 'adyen_hpp/payment_fields/base'

class AdyenHpp
  class PaymentFields
    class ResUrlField < AdyenHpp::PaymentFields::Base
      def self.adyen_field_name
        'resURL'
      end

      def convert
        return nil if @value.nil?
        String(@value)
      end

      private

      def validate errors_aggregator
        return errors_aggregator if @value.nil?
        if can_not_convert?
          errors_aggregator.add self, 'invalid type'
        end
        errors_aggregator
      end
    end
  end
end
