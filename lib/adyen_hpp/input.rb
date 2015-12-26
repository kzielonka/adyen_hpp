require 'adyen_hpp/payment_fields'

class AdyenHpp::Input
  #AdyenHpp::PaymentFields.fields.each do |field|
  #  attr_accessor field.field_name 
  #end

  def attributes= attributes
    attributes.each do |key, value|
      self.send(key, value)
    end
  end
end
