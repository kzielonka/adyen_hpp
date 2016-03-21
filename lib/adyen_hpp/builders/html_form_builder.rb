class AdyenHpp
  module Builders
    class HtmlFormBuilder
      Config = Struct.new(:adyen_url)
      DEFAULT_ADYEN_URL = 'https://live.adyen.com/hpp/select.shtml'

      class HtmlInput
        def initialize(name, value)
          @name = name
          @value = value
        end

        def to_html
          "<input type=\"hidden\" name=\"#{@name}\" value=\"#{@value}\">"
        end
      end

      def initialize(config)
        @inputs = []
        @config = config
      end

      def add_field(name, value)
        @inputs << HtmlInput.new(name, value)
      end

      def build
        form_tag do
          @inputs.collect(&:to_html).join
        end
      end

      def self.new_config
        Config.new(DEFAULT_ADYEN_URL)
      end

      private

      def url
        @config.adyen_url || DEFAULT_ADYEN_URL
      end

      def form_tag
        content = yield
        "<form action=\"#{url}\" accept-charset=\"UTF-8\" method=\"post\">" \
          "#{content}#{submit_tag}" \
          '</form>'
      end

      def submit_tag
        "<input type=\"submit\">"
      end
    end
  end
end
