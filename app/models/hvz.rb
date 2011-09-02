require 'mysql2'

class Hvz < ActiveRecord::Base
  establish_connection :hvz
end