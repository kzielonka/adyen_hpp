module AdyenHpp::StringUtils
  def self.underscore! string
    string.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    string.downcase!
  end
end
