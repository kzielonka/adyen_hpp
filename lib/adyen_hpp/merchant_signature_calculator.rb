class AdyenHpp
  class MerchantSignatureCalculator
    def initialize(hmac_key = nil)
      self.hmac_key = hmac_key
    end

    attr_reader :hmac_key

    def hmac_key=(hmac_key)
      if hmac_key.respond_to? :to_s
        @hmac_key = hmac_key
      else
        fail TypeError
      end
    end

    def calculate(payment_fields)
      fail 'hmac key not set' if @hmac_key.nil?
      params = Hash[
        payment_fields.to_a.reject(&:not_set?).map do |field|
          [field.adyen_field_name, field.convert]
        end
      ]
      AdyenHppHmacCalculator.calculate @hmac_key, params
    end
  end
end
