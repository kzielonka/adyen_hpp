require 'adyen_hpp/payment_fields/base'
require 'adyen_hpp/currencies'

class AdyenHpp::PaymentFields::CurrencyCodeField < AdyenHpp::PaymentFields::Base
  def convert
    @value.to_s.upcase
  end

  private

  def validate(errors_aggregator)
    if @value.nil?
      errors_aggregator.add_required_field_error self
    elsif !currencies.exists? convert
      errors_aggregator.add self, "#{adyen_field_name} is not valid currency code"
    end

    errors_aggregator
  end

  def currencies
    AdyenHpp::Dependencies.currencies
  end
end
