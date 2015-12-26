require 'adyen_hpp/errors'
require 'adyen_hpp/conversions'

class AdyenHpp::Form
  include AdyenHpp::Conversions

  def initialize fields
    @payment_fields = PaymentFields(fields)
  end

  def [] field_name
    @payment_fields.get field_name
  end

  def []= field_name, value
    @params[field_name] = value
  end

  def generate
    form = HtmlForm.new
    @payment_fields.map do |field, value|
      form.add_field field, value
    end
    form.generate_html
  end
end
