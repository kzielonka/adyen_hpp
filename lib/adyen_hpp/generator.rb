require 'adyen_hpp/errors'
require 'adyen_hpp/conversions'
require 'adyen_hpp/configurator'
require 'adyen_hpp/merchant_signature_calculator'

class AdyenHpp
  class Generator
    include AdyenHpp::Conversions

    def initialize(builder_class = nil, payment_fields = nil)
      @payment_fields = PaymentFields(payment_fields)
      @merchant_signature_calculator = MerchantSignatureCalculator.new
      @builder_class = builder_class
    end

    attr_reader :payment_fields

    def [](field_name)
      @payment_fields.get field_name
    end

    def []=(field_name, value)
      @params[field_name] = value
    end

    def configure(&block)
      @configurator ||= Configurator.new(
        @payment_fields,
        @merchant_signature_calculator,
        self
      )
      @configurator.configure(&block)
      calculate_merchant_signature if @payment_fields.merchant_sig.not_set?
    end

    def calculate_merchant_signature
      merchant_signature = @merchant_signature_calculator.calculate(@payment_fields)
      @payment_fields.merchant_sig = merchant_signature
    end

    def generate_html
      builder = @builder_class.new
      @payment_fields.each do |field|
        builder.add_field field.adyen_field_name, field.convert unless field.not_set?
      end
      builder.to_html
    end
  end
end
