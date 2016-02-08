module AdyenHpp::ValidationAggregators
  class MessagesAggregator
    include Enumerable

    def initialize
      @errors = []
    end

    def <<(error)
      @errors << error.freeze
    end

    def add(field, error)
      self << "#{field.adyen_field_name} #{error}".freeze
    end

    def add_required_field_error(field)
      @errors << "#{field.adyen_field_name} is required".freeze
    end

    def each
      @errors.each do |error|
        yield error
      end
    end

    def empty?
      @errors.empty?
    end
  end
end
