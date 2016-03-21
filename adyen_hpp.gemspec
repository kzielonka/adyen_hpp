Gem::Specification.new do |s|
  s.name        = 'adyen_hpp'
  s.version     = '0.0.1'
  s.date        = '2015-11-02'
  s.summary     = 'Adyen HPP'
  s.description = 'Payment HTML forms and redirection URL generator for Adyen HPP (Hosted Payment Pages) generator . Using this gem you can easily create form or redirection link which moves users to Adyen HPP page where they can finalize payment.'
  s.authors     = ['Krzysztof Zielonka']
  s.email       = 'aknolezik@gmail.com'
  s.files       = ['data/currencies.xml']
  s.files += Dir['lib/**/*.rb']
  s.license     = 'MIT'
  s.homepage    = 'https://rubygems.org/gems/adyen_hpp'

  s.add_runtime_dependency 'adyen_hpp_hmac_calculator', '~> 0.0.2', '>= 0.0.2'

  s.add_development_dependency 'rake', '~>10.4', '>= 10'
  s.add_development_dependency 'yard', '~>0.8.7', '>= 0.8'
end
