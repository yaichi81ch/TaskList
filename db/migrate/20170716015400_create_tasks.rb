class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :content
      t.string :note
      t.string :duedate

      t.timestamps
    end
  end
end
