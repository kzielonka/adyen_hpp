require 'adyen_hpp/builders/html_form_builder.rb'
require 'adyen_hpp/builders/redirection_url_builder.rb'
require 'adyen_hpp/conversions.rb'
require 'adyen_hpp/currencies.rb'
require 'adyen_hpp/dependencies.rb'
require 'adyen_hpp/string_utils.rb'
require 'adyen_hpp/payment_fields.rb'
require 'adyen_hpp/generator.rb'

require 'singleton'
require 'forwardable'

class AdyenHpp
  include Singleton

  MissingBlockError = Class.new(StandardError)
  ValidationError = Class.new(StandardError)

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
    check_validity_of(generator.payment_fields)
    generator.generate
  end

  def raise_missing_block_error
    raise MissingBlockError, 'Configuration block is required.'
  end

  def check_validity_of(payment_fields)
    return if payment_fields.valid?
    raise_validation_error_for(payment_fields)
  end

  def raise_validation_error_for(payment_fields)
    errors = payment_fields.validation_errors.collect(&:to_a).flatten
    raise ValidationError, "Errors: #{errors.join(', ')}"
  end

  class << self
    extend Forwardable
    def_delegators :instance, :form, :redirection_url
  end
end
