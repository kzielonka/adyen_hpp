Gem::Specification.new do |s|
  s.name        = 'adyen_hpp'
  s.version     = '0.0.1'
  s.date        = '2015-11-02'
  s.summary     = 'Adyen HPP'
  s.description = "Tool for generating Adyen HPP HTML POST form or redirection URL."
  s.authors     = ['Krzysztof Zielonka']
  s.email       = 'aknolezik@gmail.com'
  s.files       = [
    'lib/adyen_hpp.rb',
    'lib/adyen_hpp/input.rb'
  ]
  s.files      += Dir['lib/adyen_hpp/fields/*.rb']
  s.license     = 'MIT'
  s.homepage    = 'https://rubygems.org/gems/adyen_hpp'
  s.dependency 'currencies', require: 'iso4217'
end
