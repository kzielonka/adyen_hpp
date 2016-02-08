require 'time'

class AdyenHpp
  module Utilities
    module ISO8601TimeFormat
      def self.valid?(string)
        Time.iso8601(string)
        true
      rescue ArgumentError
        false
      end

      def self.invalid?(string)
        !valid?(string)
      end
    end
  end
end
