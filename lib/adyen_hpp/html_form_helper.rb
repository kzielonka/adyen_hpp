module AdyenHpp::HtmFormHelper
  def form_tag url_for_options = {}, options = {}, &block
    "<form>" + block.call() + "</form>"
  end

  def hidden_field_tag name, value = nil, options = {}
    '<input type="hidden"></input>'
  end

  def submit_tag value, options={}
    '<input type="submit"></input>'
  end
end
