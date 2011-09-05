class User

  attr_accessor :hvz_username, :hvz_password
  
  validate :get_hvz_user
  validates :hvz_user_id, :uniqueness => {:allow_nil => true}

  def get_hvz_user
    return if hvz_username.blank? && hvz_password.blank?
    hvz_session = HvzSession.new(hvz_username, hvz_password)
    hvz_session.send
    id = hvz_session.attributes.with_indifferent_access[:id]
    if id
      self.hvz_user_id = id
    else
      errors.add(:hvz_password, 'invalid username or password')
    end
  end
  
  def hvz_user
    @hvz_user ||= HvzUser.where(:id => hvz_user_id).first
  end
  
  def creature_type
    hvz_user.player_status[:creature_type] rescue nil
  end
  
end