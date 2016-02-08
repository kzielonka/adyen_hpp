require 'adyen_hpp/payment_fields/base'
require 'adyen_hpp/utilities/iso_8601_time_format'

class AdyenHpp
  class PaymentFields
    class SessionValidityField < AdyenHpp::PaymentFields::Base
      def convert
        # TODO: improve that method and make the same for other date field
        case @value
        when String then @value
        when Time then @value.iso8601
        else
          if @value.respond_to? :to_time
            @value.to_time.iso8601
          else
            fail TypeError, 'invalid type'
          end
        end
      end

      private

      def validate(errors_aggregator)
        if @value.nil?
          errors_aggregator.add_required_field_error self
        elsif can_not_convert?
          errors_Aggregator.add self, 'invalid type'
        elsif Utilities::ISO8601TimeFormat.invalid? convert
          errors_aggregator.add self, 'invalid format'
        end

        errors_aggregator
      end
    end
  end
end
