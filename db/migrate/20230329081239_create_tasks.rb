class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.date :due_date
      t.datetime :completed_at
      t.integer :project_id
      t.integer :user_id

      t.timestamps
    end
  end
end
