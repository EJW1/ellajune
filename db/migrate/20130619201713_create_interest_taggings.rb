class CreateInterestTaggings < ActiveRecord::Migration
  def change
    create_table :interest_taggings do |t|
      t.belongs_to :interest_tag
      t.belongs_to :user

      t.timestamps
    end
    add_index :interest_taggings, :interest_tag_id
    add_index :interest_taggings, :user_id
  end
end
