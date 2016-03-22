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

# Generates Adyen HPP form and redirection URL.
# @example Generating form:
#
#   AdyenHpp.form do |config|
#     config.hmac_key = 'f32kf943hfaaj4wg'
#     config.merchant_reference = 'MODEL-1'
#     config.payment_amount = 5553
#     config.currency_code = :eur
#     config.ship_before_date = Time.new(2020, 1, 1, 0, 0, 0)
#     config.skin_code = 'skin-code'
#     config.merchant_account = 'Account'
#     config.session_validity = Time.new(2019, 1, 1, 0, 0, 0)
#   end
#
# @example Generating redirection url:
#
#   AdyenHpp.redirection_url do |config|
#     config.hmac_key = 'f32kf943hfaaj4wg'
#     config.merchant_reference = 'MODEL-1'
#     config.payment_amount = 5553
#     config.currency_code = :eur
#     config.ship_before_date = Time.new(2020, 1, 1, 0, 0, 0)
#     config.skin_code = 'skin-code'
#     config.merchant_account = 'Account'
#     config.session_validity = Time.new(2019, 1, 1, 0, 0, 0)
#     config.hmac_key = 'f2ff4fsf'
#   end
class AdyenHpp
  include Singleton

  MissingBuilderError = Class.new(StandardError)
  MissingBlockError = Class.new(StandardError)
  ValidationError = Class.new(StandardError)

  # Generates payment form.
  def form(&config_block)
    builder = Builders::HtmlFormBuilder
    build(builder, &config_block)
  end

  # Generates payment URL.
  def redirection_url(&config_block)
    builder = Builders::RedirectionUrlBuilder
    build(builder, &config_block)
  end

  # Generates payment data with custom builder.
  #
  # @param builder [Object] must be object with defined
  #   #add_field(name, value) and #build methods.
  def build(builder, &config_block)
    raise_missing_builder_error if builder.nil?
    raise_missing_block_error if config_block.nil?
    generator = AdyenHpp::Generator.new(builder)
    generator.configure(&config_block)
    check_validity_of(generator.payment_fields)
    generator.generate
  end

  private

  def raise_missing_builder_error
    raise MissingBuilderError, 'Builder is required.'
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
    def_delegators :instance, :build, :form, :redirection_url
  end
end
