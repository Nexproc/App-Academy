class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :author_id, null: false
      t.string :title, null: false
      t.string :url
      t.text :content

      t.timestamps null: false
    end

    add_index :posts, :author_id

    add_foreign_key :posts, :users, :author_id
  end
end
