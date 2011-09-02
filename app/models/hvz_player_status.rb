class HvzPlayerStatus < HvzRequest
  
  @path = 'player_statuses'
  
  def initialize(id)
    self.path = "/#{id}"
    self.method = :get
  end

end