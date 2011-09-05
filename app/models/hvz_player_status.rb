class HvzPlayerStatus < HvzRequest
  
  @path = 'player_statuses'
  
  def initialize(id)
    self.path = "/#{id}"
    self.method = :get
  end
  
  def send
    super
    if self.attributes[:creature_type] == 'zombie' && self.attributes[:zombie_expires_at] < Time.now
      self.attributes[:creature_type] = 'dead'
    end
  end
end