require 'adyen_hpp/errors'
require 'adyen_hpp/conversions'
require 'adyen_hpp/form_configurator'
require 'adyen_hpp/merchant_signature_calculator'

class AdyenHpp
  class Form
    include AdyenHpp::Conversions

    def initialize(hmac_key = nil, payment_fields = nil)
      @payment_fields = PaymentFields(payment_fields)
      @merchant_signature_calculator = MerchantSignatureCalculator.new
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

    class FormBuilder
      class HtmlInput
        def initialize(name, value)
          @name = name
          @value = value
        end

        attr_reader :name
        attr_reader :value

        def to_html
          "<input type=\"hidden\" name=\"#{name}\" value=\"#{value}\">"
        end
      end

      def initialize
        @inputs = []
      end

      def add_field(name, value)
        @inputs << HtmlInput.new(name, value)
      end

      def to_html
        "<form>#{@inputs.collect(&:to_html).join}</form>"
      end
    end

    def generate_html
      builder = FormBuilder.new
      @payment_fields.each do |field|
        builder.add_field field.adyen_field_name, field.convert unless field.not_set?
      end
      builder.to_html
    end
  end
end
