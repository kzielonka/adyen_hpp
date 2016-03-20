require 'adyen_hpp/payment_fields/base'

class AdyenHpp
  class PaymentFields
    class BlockedMethodsField < AdyenHpp::PaymentFields::Base
      def convert
        return nil if @value.nil?
        Array(@value).map(&method(:convert_array_item)).join(',')
      end

      private

      def convert_array_item(item)
        p item
        if item.respond_to? :to_str
          item.to_str
        elsif item.is_a? Symbol
          item.to_s
        else
          raise TypeError, 'invalid type'
        end
      end

      def validate errors_aggregator
        return errors_aggregator if @value.nil?
        if can_not_convert?
          errors_aggregator.add self, 'invalid type'
        elsif convert.include?(' ')
          errors_aggregator.add self, 'can not contains spaces'
        end
        errors_aggregator
      end
    end
  end
end
