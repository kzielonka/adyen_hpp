require 'net/http'
require 'adyen_hpp/currencies/currencies_file.rb'
require 'adyen_hpp/currencies/parser.rb'

class AdyenHpp
  class Currencies
    Currency = Struct.new :number, :code, :country, :name, :minor_units

    def initialize(currencies_file_path = nil)
      @currencies_file = CurrenciesFile.new(currencies_file_path)
    end

    def exists?(code)
      initialize_currencies unless currencies_initialized?
      find_currency_by_code code.to_s
    end

    def digits_after_dot(_code)
      5
    end

    def find_currency_by_code(code)
      @currencies_by_codes[code.to_s]
    end

    def load_currencies
      file_content = @currencies_file.load
      @currencies = Parser.new.parse_from_string file_content
    end

    def currencies_initialized?
      !!@currencies_initialized
    end

    def initialize_currencies
      load_currencies
      @currencies_by_codes = @currencies.map { |currency| [currency.code.to_s, currency] }.to_h
      @currencies_initialized = true
    end
  end
end
