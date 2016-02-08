require 'adyen_hpp/payment_fields/base'

class AdyenHpp::PaymentFields::MerchantReferenceField < AdyenHpp::PaymentFields::Base
  class ArrayConverter
    def can_convert?(obj)
      obj.is_a?(Array) && each_element_can_be_converted_to_string?(obj)
    end

    def convert(array)
      array.collect(&:to_s).join('-')
    end

    private

    def each_element_can_be_converted_to_string?(array)
      array.map { |el| el.respond_to? :to_s }.reduce(:&)
    end
  end

  def convert
    array_converter = ArrayConverter.new
    if array_converter.can_convert? @value
      array_converter.convert @value
    elsif @value.respond_to? :to_s
      @value.to_s
    else
      StandardError.new 'can not convert merchant_reference field' unless @value.respond_to? :to_s
    end
  end

  private

  def validate(errors_aggregator)
    if @value.nil?
      errors_aggregator.add_required_field_error self
    elsif convert.size > 80
      errors_aggregator.add self, 'can not be longer then 80'
    end

    errors_aggregator
  end
end
