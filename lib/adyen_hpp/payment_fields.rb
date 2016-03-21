require 'adyen_hpp'
require 'adyen_hpp/utilities/require_dir.rb'
require 'adyen_hpp/utilities/fields_namespace'

class AdyenHpp
  class PaymentFields
    include Enumerable

    FIELDS_SUFFIX = 'Field'.freeze

    class << self
      def cache_defined_fields!
        @defined_fields = AdyenHpp::Utilities::FieldsNamespace.find_submodules_with_suffix(self, FIELDS_SUFFIX).sort_by(&:name)
        @defined_fields_by_name = @defined_fields.collect(&:field_name).collect(&:to_s).collect(&:freeze).zip(@defined_fields).to_h
        @defined_fields_by_adyen_name = @defined_fields.collect(&:adyen_field_name).zip(@defined_fields).to_h
      end

      def has_field?(name)
        !@defined_fields_by_name[name.to_s].nil?
      end

      def has_adyen_field?(name)
        !@defined_fields_by_adyen_name[name.to_s].nil?
      end

      attr_reader :defined_fields
    end

    def initialize(fields = {})
      @fields = initialize_fields
      fields.each { |name, value| set name, value }
    end

    def set(field_name, value)
      fail ArgumentError.new "#{field_name} is not payment field" unless self.class.has_field? field_name
      @fields[field_name.to_s].set value
    end
    alias_method :[]=, :set

    attr_reader :fields

    def get(field_name)
      fail ArgumentError.new "#{field_name} is not payment field" unless self.class.has_field? field_name
      @fields[field_name.to_s]
    end
    alias_method :[], :get

    def valid?
      @fields.values.collect(&:valid?).reduce(:&)
    end

    def validation_errors
      @fields.values.collect(&:validation_errors)
    end

    def each
      @fields.each { |_, payment_field| yield payment_field }
    end

    def respond_to?(method_name)
      super(method_name) || payment_field_method_name?(method_name)
    end

    def payment_field_method_name?(method_name)
      field_name = method_name.to_s.chomp('=')
      self.class.has_field?(field_name)
    end

    private

    def method_missing(method, *args, &block)
      if method.to_s.end_with? '='
        set method.to_s.chomp('='), *args, &block
      else
        get method
      end
    rescue ArgumentError
      super method, *args, &block
    end

    def initialize_fields
      field_names = self.class.defined_fields.collect(&:field_name)
      field_instances = self.class.defined_fields.map { |field_class| field_class.new nil, self }
      field_names.zip(field_instances).to_h
    end
  end
end

Dir[File.expand_path('payment_fields/*_field.rb', File.dirname(__FILE__))].each { |file| require file }
AdyenHpp::PaymentFields.cache_defined_fields!
