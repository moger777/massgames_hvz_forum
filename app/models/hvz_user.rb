class HvzUser < Hvz
  set_table_name :users
  
  def player_status
    r = HvzPlayerStatus.new(id)
    r.send
    return r.attributes
  end
  
  def user
    user = User.find_by_hvz_user_id(self.id)
    unless user
      user = User.new
      user.login = self.username
      user.email = self.email_address
      user.hvz_user_id = self.id
      user.admin = self.is_admin
      user.save
    end
    user
  end
end
