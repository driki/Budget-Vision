class User < ActiveRecord::Base
  has_many :organizations, :through => :organization_users
end
