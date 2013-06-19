class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :link
      t.integer :points

      t.timestamps
    end
  end
end
