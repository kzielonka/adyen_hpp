require 'adyen_hpp/payment_fields'

class AdyenHpp
  module Conversions
    def PaymentFields(value)
      case value
      when PaymentFields then value
      when NilClass then PaymentFields.new
      else fail TypeError, 'invalid type'
      end
    end
  end
end
