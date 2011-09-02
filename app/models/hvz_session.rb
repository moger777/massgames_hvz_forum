class HvzSession < HvzRequest
  
  @path = 'user_sessions'
  
  def initialize(username, password)
    self.path = ".xml"
    self.method = :post
    self.root = :user_session
    self.form_data = {:username => username, :password => password}
  end

end