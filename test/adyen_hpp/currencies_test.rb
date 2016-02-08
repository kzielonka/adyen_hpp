require 'minitest/autorun'
require 'adyen_hpp'
require 'adyen_hpp/currencies.rb'

class CurrenciesTest < Minitest::Test
  def setup
    @currencies = AdyenHpp::Currencies.new
    @currencies_file = <<-XML
      <ISO_4217 Pblshd="2015-06-19">
        <CcyTbl>
          <CcyNtry>
            <CtryNm>POLAND</CtryNm>
            <CcyNm>Zloty</CcyNm>
            <Ccy>PLN</Ccy>
            <CcyNbr>985</CcyNbr>
            <CcyMnrUnts>2</CcyMnrUnts>
          </CcyNtry>
          <CcyNtry>
            <CtryNm>ÅLAND ISLANDS</CtryNm>
            <CcyNm>Euro</CcyNm>
            <Ccy>EUR</Ccy>
            <CcyNbr>978</CcyNbr>
            <CcyMnrUnts>2</CcyMnrUnts>
          </CcyNtry>
        </CcyTbl>
      </ISO_4217>
    XML
  end

  def test_valid_currency_code_existance
    File.stub :read, @currencies_file do
      assert @currencies.exists? 'EUR'
    end
  end

  def test_invalid_currency_code_existance
    File.stub :read, @currencies_file do
      refute @currencies.exists? 'INVALID CURRENCY CODE'
    end
  end
end
