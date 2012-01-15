class User < ActiveRecord::Base
	has_paper_trail
  has_many :organizations, :through => :organization_users
end
