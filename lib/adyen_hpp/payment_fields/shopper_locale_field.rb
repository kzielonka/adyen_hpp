require 'adyen_hpp/payment_fields/base'

class AdyenHpp
  class PaymentFields
    class ShopperLocaleField < AdyenHpp::PaymentFields::Base
      def convert
        if @value.respond_to? :to_s
          @value.to_s
        else
          fail TypeError, 'invalid type'
        end
      end

      private

      def validate(errors_aggregator)
        return errors_aggregator if @value.nil?
        if can_not_convert?
          errors_aggregator.add self, 'invalid type'
        elsif not valid_format?
          errors_aggregator.add self, 'invalid format'
        end
        errors_aggregator
      end

      def valid_format?
        convert.match(/^\w+(_\w+)?$/)
      end
    end
  end
end
