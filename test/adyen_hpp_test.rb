require 'minitest/autorun'
require 'adyen_hpp'

class AdyenHppTest < Minitest::Test
  def setup
    @adyen_hpp = AdyenHpp.new
  end

  def test_building_form
    result = AdyenHpp.form do |form|
      form.hmac_key = 'afdasdfdasfads'
      form.merchant_reference = 'ORDER-12345'
      form.payment_amount = 55.54
      form.currency_code = :eur
      form.ship_before_date = Time.new(2016, 2, 2, 0, 26, 0, 1)
      form.skin_code = 'SkInCoDe'
      form.merchant_account = 'Account'
      form.session_validity = Time.new(2016, 2, 3, 0, 12, 32, 1)
    end
    expected_result = <<-HTML
      <form action="https://live.adyen.com/hpp/select.shtml" accept-charset="UTF-8" method="post">
        <input type="hidden" name="currencyCode" value="EUR">
        <input type="hidden" name="merchantAccount" value="Account">
        <input type="hidden" name="merchantReference" value="ORDER-12345">
        <input type="hidden" name="merchantSig" value="y5xM8bw2pR6CBqD7vWvAqyGeq3KYK9bREmVCTBLU9tM=">
        <input type="hidden" name="paymentAmount" value="5554">
        <input type="hidden" name="sessionValidity" value="2016-02-03T00:12:32+00:00">
        <input type="hidden" name="shipBeforeDate" value="2016-02-02T00:26:00+00:00">
        <input type="hidden" name="skinCode" value="SkInCoDe">
        <input type="submit">
      </form>
    HTML
    assert_equal expected_result.gsub(/^\s+/, '').gsub(/\s$/, '').delete("\n"), result
  end

  def test_building_redirection_url
    result = AdyenHpp.redirection_url do |config|
      config.hmac_key = 'afdasdfdasfads'
      config.merchant_reference = 'ORDER-12345'
      config.payment_amount = 55.54
      config.currency_code = :eur
      config.ship_before_date = Time.new(2016, 2, 2, 0, 26, 0, 1)
      config.skin_code = 'SkInCoDe'
      config.merchant_account = 'Account'
      config.session_validity = Time.new(2016, 2, 3, 0, 12, 32, 1)
      config.adyen_url = 'http://www.adyen.com'
    end
    expected_result = <<-HTML
      http://www.adyen.com
        ?currencyCode=EUR
        &merchantAccount=Account
        &merchantReference=ORDER-12345
        &merchantSig=y5xM8bw2pR6CBqD7vWvAqyGeq3KYK9bREmVCTBLU9tM%3D
        &paymentAmount=5554
        &sessionValidity=2016-02-03T00%3A12%3A32%2B00%3A00
        &shipBeforeDate=2016-02-02T00%3A26%3A00%2B00%3A00
        &skinCode=SkInCoDe
    HTML
    assert_equal expected_result.gsub(/^\s+/, '').gsub(/\s$/, '').delete("\n"), result
  end

  def test_building_invalid_form
    assert_raises AdyenHpp::ValidationError do
      AdyenHpp.form do |form|
        form.hmac_key = 'asfasfafd'
        form.payment_amount = 55.54
        form.currency_code = :eur
      end
    end
  end

  def test_raise_error_on_missing_block
    assert_raises AdyenHpp::MissingBlockError do
      AdyenHpp.form
    end
  end
end
