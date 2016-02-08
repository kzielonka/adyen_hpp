require 'object_without_to_s'

module StringFieldsSharedTests
  def test_valid_when_value_is_nil
    @field.set nil
    assert @field.valid?
  end

  def test_invalid_when_object_can_not_be_converted
    @field.set ObjectWithoutToS.new
    refute @field.valid?
  end

  def test_valid_for_string
    @field.set 'string'
    assert @field.valid?
  end

  def test_valid_for_symbol
    @field.set :symbol
    assert @field.valid?
  end

  def test_convert_string
    @field.set 'string'
    assert_equal 'string', @field.convert
  end

  def test_convert_symbol
    @field.set :symbol
    assert_equal 'symbol', @field.convert
  end

  def test_convert_object_without_to_s_method
    @field.set ObjectWithoutToS.new
    assert_raises TypeError do
      @field.convert
    end
  end

end
