[![Build Status](https://travis-ci.org/kzielonka/adyen_hpp.svg?branch=master)](https://travis-ci.org/kzielonka/adyen_hpp)

# Adyen HPP
Ruby gem for generating Adyen HPP payment HTML POST form and redirection URL.
It creates form/url with all needed data and calculated signature.
Based on Adyen HPP documentation:
https://docs.adyen.com/manuals/hpp-manual#hostedpaymentpages 

## Usage
To generate form use **AdyenHpp#form**:

```ruby
AdyenHpp.form do |config|
  config.hmac_key = 'f32kf943hfaaj4wg'
  config.merchant_reference = 'MODEL-1'
  config.payment_amount = 5553
  config.currency_code = :eur
  config.ship_before_date = Time.new(2020, 1, 1, 0, 0, 0)
  config.skin_code = 'skin-code'
  config.merchant_account = 'Account'
  config.session_validity = Time.new(2019, 1, 1, 0, 0, 0)
end
```

To generate redirection url use **AdyenHpp::redirection_url**:

```ruby
AdyenHpp.redirection_url do |config|
  config.hmac_key = 'f32kf943hfaaj4wg'
  config.merchant_reference = 'MODEL-1'
  config.payment_amount = 5553
  config.currency_code = :eur
  config.ship_before_date = Time.new(2020, 1, 1, 0, 0, 0)
  config.skin_code = 'skin-code'
  config.merchant_account = 'Account'
  config.session_validity = Time.new(2019, 1, 1, 0, 0, 0)
  config.hmac_key = 'f2ff4fsf'
end
```
