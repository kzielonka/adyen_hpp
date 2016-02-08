module AdyenHpp::Utilities
  module FieldsNamespace
    FIELDS_SUFFIX = 'Field'.freeze

    def get_defined_fields
      fields = constants
      fields.collect!(&:to_s)
      fields.select! { |item| item.end_with? FIELDS_SUFFIX }
      fields.map! { |const_name| namespace.const_get(const_name.to_s) }
    end

    def self.find_submodules_with_suffix(source_module, suffix)
      submodules = source_module.constants
      submodules.collect!(&:id2name)
      submodules.select! { |submodule| submodule.end_with? suffix }
      submodules.map! { |const_name| source_module.const_get(const_name.to_s) }
    end

    def self.extract_field_name_from(class_name)
      name = class_name.split('::').last
      name.slice!(FIELDS_SUFFIX.size * -1..-1)
      AdyenHpp::StringUtils.underscore!(name)
      name.to_sym
    end
  end
end
