require 'adyen_hpp/utilities/fields_namespace'

class AdyenHpp::PaymentFields::Base
  def initialize value = nil
    @value = value 
  end

  def set value
    @value = value
  end

  def get
    @value
  end

  def validate
    []
  end

  def valid?
    validate.empty?
  end

  def field_name
    self.class.field_name
  end

  def adyen_field_name
    self.class.adyen_field_name
  end

  class << self
    def field_name
      return @field_name if @field_name
      @field_name = self.name.split('::').last 
      @field_name.slice! AdyenHpp::PaymentFields::FIELDS_SUFFIX.size * -1 .. -1
      AdyenHpp::StringUtils.underscore!(field_name)
      @field_name.to_sym
    end

    def adyen_field_name
      return @adyen_field_name if @adyen_field_name
      @adyen_field_name = self.name.split('::').last 
      @adyen_field_name.slice! AdyenHpp::PaymentFields::FIELDS_SUFFIX.size * -1 .. -1
      @adyen_field_name = @adyen_field_name[0].downcase + @adyen_field_name[1..-1]
    end 
  end
end
