require 'adyen_hpp'
require 'adyen_hpp/utilities/require_dir.rb'
require 'adyen_hpp/utilities/fields_namespace'


class AdyenHpp::PaymentFields
  FIELDS_SUFFIX = 'Field'.freeze

  class << self
    def cache_defined_fields!
      @defined_fields = AdyenHpp::Utilities::FieldsNamespace.find_submodules_with_suffix self, FIELDS_SUFFIX
      @defined_fields_by_name = @defined_fields.collect(&:field_name).collect(&:to_s).collect(&:freeze).zip(@defined_fields).to_h
      @defined_fields_by_adyen_name = @defined_fields.collect(&:adyen_field_name).zip(@defined_fields).to_h
    end

    def has_field? name
      !@defined_fields_by_name[name.to_s].nil?
    end

    def has_adyen_field? name
      !@defined_fields_by_adyen_name[name.to_s].nil?
    end

    attr_reader :defined_fields
  end

  def initialize fields={}
    @fields = initialize_fields
    fields.each { |name, value| set name, value }
  end
  
  def set field_name, value
    raise ArgumentError.new "#{field_name} is not payment field" unless self.class.has_field? field_name
    @fields[field_name.to_s].set value
  end
  alias_method :[]=, :set

  def get field_name
    raise ArgumentError.new "#{field_name} is not payment field" unless self.class.has_field? field_name
    @fields[field_name.to_s].get
  end
  alias_method :[], :get

  def valid?
    @fields.collect(&:valid?).reduce(:&)
  end

  private

  def initialize_fields
    field_names = self.class.defined_fields.collect(&:field_name)
    field_instances = self.class.defined_fields.collect(&:new)
    field_names.zip(field_instances).to_h
  end
end

Dir[File.expand_path('payment_fields/*_field.rb', File.dirname(__FILE__))].each { |file| require file }
AdyenHpp::PaymentFields.cache_defined_fields!
