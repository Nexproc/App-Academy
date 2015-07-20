class CreateSubLinks < ActiveRecord::Migration
  def change
    create_table :sub_links do |t|
      t.integer :post_id, null: false
      t.integer :sub_id, null: false
      t.timestamps null: false
    end

    add_index :sub_links, :post_id
    add_index :sub_links, :sub_id

    add_foreign_key :sub_links, :posts
    add_foreign_key :sub_links, :subs
  end
end
