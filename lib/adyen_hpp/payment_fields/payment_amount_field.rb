require 'adyen_hpp/payment_fields/base'

class AdyenHpp
  class PaymentFields
    class PaymentAmountField < AdyenHpp::PaymentFields::Base
      class StringConverter
        def convert(obj)
          raise ArgumentError.new "can not convert #{obj.class.name}" unless can_convert? obj
          if float_string? obj
            (obj.match(/^\d*.\d+$/)[0].to_f * 100).to_i
          else
            obj.match(/^\d*.\d+$/)[0].to_i
          end
        end

        def can_convert?(obj)
          obj.is_a?(String) && (float_string?(obj) || integer_string?(obj))
        end

        def float_string?(str)
          str.match /^\d*\.\d+$/
        end

        def integer_string?(str)
          str.match /^\d+$/
        end
      end

      def initialize(value, payment_fields)
        raise MissingPaymentFieldsError.new if payment_fields.nil?
        super value, payment_fields
        @string_converter = StringConverter.new
      end

      def convert
        return @string_converter.convert @value if @string_converter.can_convert? @value
        return (@value * 100).to_i if @value.is_a? Float
        @value.to_i
      end

      private

      def validate(errors_aggregator)
        if @value.nil?
          errors_aggregator.add_required_field_error self
        elsif not@string_converter.can_convert?(@value) || @value.is_a?(Float) || @value.respond_to?(:to_i)
          errors_aggregator.add self, "must be Flaot or responds to 'to_i'"
        elsif !currency_code_field.valid?
          errors_aggregator.add self, "requires to set #{currency_code_field.adyen_field_name}"
       end

        errors_aggregator
      end

      def convert_float(payment_amount)
        payment_amount * 100
      end

      def currency_code_field
        @payment_fields.currency_code
      end
    end
  end
end
