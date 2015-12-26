require 'adyen_hpp/payment_fields/base'
require 'adyen_hpp/currencies'

class AdyenHpp::PaymentFields::CurrencyCodeField < AdyenHpp::PaymentFields::Base
  def validate
    errors = []

    if @value.nil? 
      errors << "#{adyen_field_name} is required"
    elsif not currencies.exists? value
      errors << "#{adyen_field_name} is not valid currency code"
    end
 
    errors
  end

  def convert
    @value.to_s.upcase
  end

  private

  def currencies
  end
end
