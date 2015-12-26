class AdyenHpp
  def initialize skins_secrets
    @skins_secrets = skins_secrets
  end

  def self.generate_form params, dependencies
    self.new(params).generate
  end

  def self.generate_url params
  end
end

require 'adyen_hpp/conversions.rb'
require 'adyen_hpp/string_utils.rb'
require 'adyen_hpp/payment_fields.rb'
require 'adyen_hpp/input.rb'
require 'adyen_hpp/form.rb'
