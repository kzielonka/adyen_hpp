class AdyenHpp
  class Form
    class Configurator
      def initialize(*config_objects)
        @config_objects = config_objects
      end

      def configure
        yield self
      end

      MethodMissingArgs = Struct.new(:name, :args, :block) do
        def method_exists_on?(object)
          object.respond_to? name
        end

        def invoke_on(object)
          object.send(name, *args, &block)
        end
      end

      def method_missing(name, *args, &block)
        method_missing_args = MethodMissingArgs.new(name, args, block)
        @config_objects.each do |config_object|
          if method_missing_args.method_exists_on?(config_object)
            method_missing_args.invoke_on config_object
            break
          end
        end
      end

      private

      def invoke_on(method_missing_args)
        method_missing_args.apply @payment_fields
      rescue NoMethodError
        yield
      end

      def invoke_on_form(method_missing_args)
        method_missing_args.apply @form
      rescue NoMethodError
        raise "#{method_missing_args.name} is not valid configuraton parameter"
      end
    end
  end
end
