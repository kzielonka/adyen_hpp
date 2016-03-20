class AdyenHpp::Dependencies
  class << self
    def currencies
      @currencies ||= AdyenHpp::Currencies.new
    end
  end
end
