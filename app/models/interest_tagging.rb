class InterestTagging < ActiveRecord::Base
  belongs_to :interest_tag
  belongs_to :user
  # attr_accessible :title, :body
end
