class AddVideoColumnToPosts < ActiveRecord::Migration
  def change
    add_attachment :posts, :video 
  end
end
