module AdyenHpp::Conversions
  def PaymentFields value
    if value.is_a? PaymentFields
      value
    else
      PaymentFields.new value
    end
  end
end
