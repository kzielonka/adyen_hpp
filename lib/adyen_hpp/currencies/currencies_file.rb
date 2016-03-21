class AdyenHpp
  class Currencies
    class CurrenciesFile
      DEFAULT_CURRENCIES_FILE_PATH = File.join(
        File.dirname(__FILE__), '..', '..', '..', 'data', 'currencies.xml'
      ).freeze
      DEFAULT_CURRENCIES_URL = 'http://www.currency-iso.org/dam/downloads/lists/list_one.xml'.freeze

      def initialize(file_path = nil)
        @file_path = file_path || DEFAULT_CURRENCIES_FILE_PATH
      end

      attr_reader :file_path

      def import(url = nil)
        url ||= DEFAULT_CURRENCIES_URL
        uri = URI(url)
        currencies_xml = Net::HTTP.get(uri)
        File.open(file_path, 'w') { |f| f.write currencies_xml }
      end

      def self.import
        new.import
      end

      def load
        File.read(file_path)
      end

      def self.load
        new.load
      end
    end
  end
end
