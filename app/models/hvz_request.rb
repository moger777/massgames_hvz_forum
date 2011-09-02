require 'net/http'

class HvzRequest
  include ActiveModel::Validations
  
  validate :no_errors
  
  attr_accessor :path, :request, :response, :form_data, :method, :attributes, :root
  
  def self.path
    @path
  end
  
  case Rails.env
  when 'development' then @@host = 'http://localhost:3000/'
  when 'production'  then @@host = 'http://hvz.massgamesrso.org/'
  end
  
  def self.host
    @@host
  end
  
  def send
    url = URI.parse(self.class.host + self.class.path + path)
    case method
    when :post then self.request = Net::HTTP::Post.new(url.path)
    when :get  then self.request = Net::HTTP::Get.new(url.path)
    end
    self.request.body = form_data.to_xml(:root => root) if form_data
    self.request.content_type = 'text/xml'
    self.response = Net::HTTP.start(url.host, url.port) {|http| http.request(self.request)}
    self.attributes = Hash.from_xml(self.response.body).values.first
  end
  
  private
  
  def no_errors
  end
end