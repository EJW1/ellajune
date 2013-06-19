class CreatePostTaggings < ActiveRecord::Migration
  def change
    create_table :post_taggings do |t|
      t.belongs_to :post_tag
      t.belongs_to :post

      t.timestamps
    end
    add_index :post_taggings, :post_tag_id
    add_index :post_taggings, :post_id
  end
end
