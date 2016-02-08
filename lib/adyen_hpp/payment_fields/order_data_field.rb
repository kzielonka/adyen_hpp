require 'adyen_hpp/payment_fields/base'
require 'base64'

class AdyenHpp
  class PaymentFields
    class OrderDataField < AdyenHpp::PaymentFields::Base
      def convert
        if @value.respond_to? :to_s
          value = @value.to_s
          compresed_value = Zlib::Deflate.deflate(value)
          Base64.encode64 compresed_value
        else
          fail TypeError, 'invalid type'
        end
      end

      private

      def validate(errors_aggregator)
        return errors_aggregator if @value.nil?
        if can_not_convert?
          errors_aggregator.add self, 'can not convert'
        end
        errors_aggregator
      end
    end
  end
end
