require 'nokogiri'

class AdyenHpp::Currencies
  class Parser
    def parse_from_string(str)
      doc = parse str
      entries(doc).map { |entry| build_currency_from entry }
    end

    private

    def parse(str)
      Nokogiri.XML(str, &:noblanks)
    end

    def entries(doc)
      doc.xpath('//ISO_4217/CcyTbl/CcyNtry')
    end

    def build_currency_from(entry)
      currency = Currency.new
      currency.country = get_country entry
      currency.name = get_currency entry
      currency.code = get_code entry
      currency.number = get_number entry
      currency.minor_units = get_minor_units entry
      currency
    end

    def get_value_from(entry, node_name)
      node = entry.xpath("#{node_name}")
      node.first.content if node.first
    end

    def get_country(entry)
      get_value_from(entry, 'CtryNm')
    end

    def get_currency(entry)
      get_value_from(entry, 'CcyNm')
    end

    def get_code(entry)
      get_value_from(entry, 'Ccy')
    end

    def get_number(entry)
      get_value_from(entry, 'CcyNbr')
    end

    def get_minor_units(entry)
      get_value_from(entry, 'CcyMnrUnts')
    end
  end
end
