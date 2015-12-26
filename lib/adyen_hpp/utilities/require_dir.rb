module Utilities
  module RequireDir
    def self.require_dir dir_path
      current_dir = File.dirname(__FILE__)
      gem_dir = File.expand_path('../..', current_dir)
      full_path = File.expand_path(dir_path.to_s + '/*.rb', gem_dir)
      Dir[full_path].each { |file| require file }
    end

    def self.require_payment_fields
      require_dir 'adyen_hpp/payment_fields'

    end
  end
end
