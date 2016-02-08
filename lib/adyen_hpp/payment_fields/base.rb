require 'adyen_hpp/string_utils'
require 'adyen_hpp/utilities/fields_namespace'
require 'adyen_hpp/validation_aggregators/messages_aggregator'

class AdyenHpp
  class PaymentFields
    class Base
      MissingPaymentFieldsError = Class.new(RuntimeError)

      def initialize(value = nil, payment_fields = nil)
        @value = value
        @payment_fields = payment_fields
      end

      def set(value)
        @value = value
      end

      def get
        @value
      end

      attr_reader :value

      def not_set?
        @value.nil?
      end

      def validation_errors
        validate(AdyenHpp::ValidationAggregators::MessagesAggregator.new)
      end

      def valid?
        validate(AdyenHpp::ValidationAggregators::MessagesAggregator.new).empty?
      end

      def field_name
        self.class.field_name
      end

      def adyen_field_name
        self.class.adyen_field_name
      end

      attr_reader :payment_fields

      class << self
        def field_name
          return @field_name if @field_name
          @field_name = name.split('::').last
          @field_name.slice! AdyenHpp::PaymentFields::FIELDS_SUFFIX.size * -1..-1
          AdyenHpp::StringUtils.underscore!(field_name)
          @field_name.to_sym
        end

        def adyen_field_name
          return @adyen_field_name if @adyen_field_name
          @adyen_field_name = name.split('::').last
          @adyen_field_name.slice! AdyenHpp::PaymentFields::FIELDS_SUFFIX.size * -1..-1
          @adyen_field_name = @adyen_field_name[0].downcase + @adyen_field_name[1..-1]
        end
      end

      def can_not_convert?
        convert
        false
      rescue TypeError
        true
      end

      protected

      def validate(_errors_aggregator)
        []
      end
    end
  end
end
