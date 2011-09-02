class HvzUser < Hvz
  set_table_name :users
  
  def player_status
    r = HvzPlayerStatus.new(id)
    r.send
    return r.attributes
  end
end
