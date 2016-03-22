class AdyenHpp
  # Calculates merchant signature from AdyenHpp::PaymentFields.
  class MerchantSignatureCalculator
    def initialize(hmac_key = :not_set)
      self.hmac_key = hmac_key unless hmac_key == :not_set
    end

    attr_reader :hmac_key

    def hmac_key=(hmac_key)
      raise TypeError unless hmac_key.respond_to?(:to_str)
      @hmac_key = hmac_key.to_str
    end

    def calculate(payment_fields)
      raise 'hmac key is required' if @hmac_key.nil?
      params = payment_fields_to_params(payment_fields)
      AdyenHppHmacCalculator.calculate @hmac_key, params
    end

    private

    def payment_fields_to_params(payment_fields)
      not_empty_fields = payment_fields.to_a.reject(&:not_set?)
      not_empty_fields.each_with_object({}) do |field, hash|
        hash[field.adyen_field_name] = field.convert
      end
    end
  end
end
