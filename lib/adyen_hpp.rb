require 'adyen_hpp/builders/html_form_builder.rb'
require 'adyen_hpp/conversions.rb'
require 'adyen_hpp/currencies.rb'
require 'adyen_hpp/dependencies.rb'
require 'adyen_hpp/string_utils.rb'
require 'adyen_hpp/payment_fields.rb'
require 'adyen_hpp/generator.rb'

class AdyenHpp
  def self.form(&config_block)
    form = AdyenHpp::Generator.new Builders::HtmlFormBuilder
    form.configure(&config_block)
    form.generate_html
  end

  def self.url(&config_block)

  end
end
