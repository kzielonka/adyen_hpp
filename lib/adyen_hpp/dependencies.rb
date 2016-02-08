class AdyenHpp::Dependencies
  include Singleton

  def currencies
    @currencies ||= AdyenHpp::Currencies.new
  end
end
