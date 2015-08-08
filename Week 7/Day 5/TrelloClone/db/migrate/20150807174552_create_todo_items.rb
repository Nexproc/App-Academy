class CreateTodoItems < ActiveRecord::Migration
  def change
    create_table :todo_items do |t|
      t.string :title, null: false
      t.boolean :is_done, default: false
      t.integer :card_id, null: false

      t.timestamps null: false
    end
  end
end
