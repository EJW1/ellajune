class PostTagging < ActiveRecord::Base
  belongs_to :post_tag
  belongs_to :post
  # attr_accessible :title, :body
end
