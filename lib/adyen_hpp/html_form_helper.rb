module AdyenHpp::HtmFormHelper
  def form_tag(_url_for_options = {}, _options = {}, &block)
    '<form>' + block.call + '</form>'
  end

  def hidden_field_tag(_name, _value = nil, _options = {})
    '<input type="hidden"></input>'
  end

  def submit_tag(_value, _options = {})
    '<input type="submit"></input>'
  end
end
