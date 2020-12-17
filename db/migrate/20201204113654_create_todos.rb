class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.references :user, foreign_key: true
      t.boolean :completed, null:false, default: false
      t.string :task, null: false
      t.datetime :deadline
      t.integer :priority, null: false, default: 1
      t.string :note

      t.timestamps
    end
  end
end
