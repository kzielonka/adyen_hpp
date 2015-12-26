require 'adyen_hpp/payment_fields/base'

class AdyenHpp::PaymentFields::PaymentAmountField < AdyenHpp::PaymentFields::Base
  def self.valid? input_value
    case value
    when Float then
      if Float.nan?
        raise ArgumentError, "Payment amount can not be NaN."
      elsif input_value - input_value.to_i != 0
        raise ArgumentError, "Invalid number."
      end
    else true
    end
  end

  def self.convert value
    case value
    when Float then (input_value * number_of_fraction_digits).to_i
    when Integer then value
    else raise TypeError.new "Payment amount value must be Float or Integer."
    end
  end

  def number_of_fraction_digits
    unless @payment_fields.country_code.valid?
      raise RuntimeError.new "Country code invalid"
    end
    case @payment_fields.country_code.value
      when 'EUR' then 2
      when 'TND' then 3
    end
  end
end
