require 'adyen_hpp/payment_fields/base'

class AdyenHpp::PaymentFields::MerchantReferenceField < AdyenHpp::PaymentFields::Base
  def validate
    errors = []
    
    if @value.nil?
      errors << "#{adyen_field_name} is required"      
    end
    
    if convert.size > 80
      errors << "#{adyen_field_name} can not be longer then 80"
    end

    errors
  end

  def convert
    if @value.is_a? Array and @value.map{ |v| v.respond_to? :to_s }.reduce(:&)
      @value.collect(&:to_s).join('-')
    elsif @value.respond_to? :to_s
      @value.to_s
    else
      StandardError.new "can not convert merchant_reference field" unless @value.respond_to? :to_s
    end
  end
end
