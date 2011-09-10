class HvzUser < Hvz
  set_table_name :users
  
  def player_status
    r = HvzPlayerStatus.new(id)
    r.send
    return r.attributes
  end
  
  def user
    User.find_by_hvz_user_id(self.id)
  end
end
