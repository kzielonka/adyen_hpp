require 'adyen_hpp/payment_fields/base'
require 'base64'
require 'stringio'
require 'zlib'

class AdyenHpp
  class PaymentFields
    class OrderDataField < Base
      def convert
        compress_and_encode String(@value)
      end

      private

      def validate(errors_aggregator)
        return errors_aggregator if @value.nil?
        errors_aggregator.add self, 'can not convert' if can_not_convert?
        errors_aggregator
      end

      def compress_and_encode(string)
        compressed_string = compress string
        encode compressed_string
      end

      def compress(string)
        io = StringIO.new
        gzip_string io, string
        io.string
      end

      def gzip_string(io, string)
        gzip_writer = Zlib::GzipWriter.new(io)
        gzip_writer.write string
        gzip_writer.close
      end

      def encode(string)
        Base64.encode64(string).delete("\n")
      end
    end
  end
end
