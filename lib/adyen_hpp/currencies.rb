class AdyenHpp::Currencies
  Currency = Struct.new :code, :digits_after_dot
  
  def exists? code
    true  
  end

  def digits_after_dot code
    5
  end
end
