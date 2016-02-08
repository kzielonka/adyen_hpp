Gem::Specification.new do |s|
  s.name        = 'adyen_hpp'
  s.version     = '0.0.1'
  s.date        = '2015-11-02'
  s.summary     = 'Adyen HPP'
  s.description = 'Adyen HPP (Hosted Payment Pages) is a HTML form and redirection URL generator.'
  s.authors     = ['Krzysztof Zielonka']
  s.email       = 'aknolezik@gmail.com'
  s.files       = [
    'lib/adyen_hpp.rb',
    'lib/adyen_hpp/input.rb'
  ]
  s.files += Dir['lib/adyen_hpp/fields/*.rb']
  s.license     = 'MIT'
  s.homepage    = 'https://rubygems.org/gems/adyen_hpp'
  s.dependency 'adyen_hpp_hmac_calculator', '~> 0.2', '>= 0.2'
  s.add_development_dependency 'rake', '~> 1.8', '>= 1.0.0'
end
