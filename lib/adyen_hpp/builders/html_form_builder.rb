class AdyenHpp
  module Builders
    class HtmlFormBuilder
      class HtmlInput
        def initialize(name, value)
          @name = name
          @value = value
        end

        def to_html
          "<input type=\"hidden\" name=\"#{@name}\" value=\"#{@value}\">"
        end
      end

      def initialize
        @inputs = []
      end

      def add_field(name, value)
        @inputs << HtmlInput.new(name, value)
      end

      def build
        form_tag do
          @inputs.collect(&:to_html).join
        end
      end

      private

      def url
        'https://live.adyen.com/hpp/select.shtml'
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
