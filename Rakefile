require 'rake/testtask'

task :environment do
  $LOAD_PATH.unshift File.expand_path('./lib/', File.dirname(__FILE__))
  require 'adyen_hpp'
end

desc 'Imports currencies file'
task import_currencies: :environment do
  AdyenHpp::Currencies::CurrenciesFile.import
  AdyenHpp::Currencies.new.load_currencies
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Run tests'
task default: :test
