require 'adyen_hpp/builders/html_form_builder.rb'
require 'adyen_hpp/builders/redirection_url_builder.rb'
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
    form.generate
  end

  def self.redirection_url(&config_block)
    form = AdyenHpp::Generator.new Builders::RedirectionUrlBuilder
    form.configure(&config_block)
    form.generate
  end
end
