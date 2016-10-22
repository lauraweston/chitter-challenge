require "data_mapper"
require "dm-postgres-adapter"

class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :user_name, String
  property :email, String

end

DataMapper.setup(:default, "postgres://localhost/chitter_test")
DataMapper.finalize
DataMapper.auto_upgrade!
