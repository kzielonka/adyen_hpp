class AdyenHpp
  def initialize(skins_secrets=nil)
    @skins_secrets = skins_secrets
  end

  def self.form(&config_block)
    form = AdyenHpp::Form.new
    form.configure(&config_block)
    form.generate_html
  end

  def self.url(&config_block)

  end
end

require 'adyen_hpp/conversions.rb'
require 'adyen_hpp/currencies.rb'
require 'adyen_hpp/dependencies.rb'
require 'adyen_hpp/string_utils.rb'
require 'adyen_hpp/payment_fields.rb'
require 'adyen_hpp/form.rb'
