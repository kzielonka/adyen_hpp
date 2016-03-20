require 'adyen_hpp/builders/html_form_builder.rb'
require 'adyen_hpp/builders/redirection_url_builder.rb'
require 'adyen_hpp/conversions.rb'
require 'adyen_hpp/currencies.rb'
require 'adyen_hpp/dependencies.rb'
require 'adyen_hpp/string_utils.rb'
require 'adyen_hpp/payment_fields.rb'
require 'adyen_hpp/generator.rb'

class AdyenHpp
  MissingBlockError = Class.new(StandardError)

  class << self
    def form(&config_block)
      builder = Builders::HtmlFormBuilder
      configure_and_generate(builder, &config_block)
    end

    def redirection_url(&config_block)
      builder = Builders::RedirectionUrlBuilder
      configure_and_generate(builder, &config_block)
    end

    private

    def configure_and_generate(builder, &config_block)
      raise_missing_block_error if config_block.nil?
      generator = AdyenHpp::Generator.new(builder)
      generator.configure(&config_block)
      generator.generate
    end

    def raise_missing_block_error
      raise MissingBlockError, 'Configuration block is required.'
    end
  end
end
