require 'adyen_hpp/errors'
require 'adyen_hpp/conversions'
require 'adyen_hpp/configurator'
require 'adyen_hpp/merchant_signature_calculator'

class AdyenHpp
  class Generator
    include AdyenHpp::Conversions

    def initialize(builder_class = nil, payment_fields = nil)
      @payment_fields = PaymentFields(payment_fields)
      @sig_calculator = MerchantSignatureCalculator.new
      @builder_class = builder_class
      @builder_config = builder_class.new_config
    end

    attr_reader :payment_fields

    def configure(&block)
      @configurator ||= Configurator.new(
        @payment_fields,
        @sig_calculator,
        @builder_config,
        self
      )
      @configurator.configure(&block)
      calculate_merchant_signature if @payment_fields.merchant_sig.not_set?
    end

    def calculate_merchant_signature
      merchant_signature = @sig_calculator.calculate(@payment_fields)
      @payment_fields.merchant_sig = merchant_signature
    end

    def generate
      builder = @builder_class.new(@builder_config)
      @payment_fields.each do |field|
        next if field.not_set?
        builder.add_field(field.adyen_field_name, field.convert)
      end
      builder.build
    end
  end
end
