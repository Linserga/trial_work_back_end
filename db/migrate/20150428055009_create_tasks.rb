class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.references :user
      t.boolean :state, default: false

      t.timestamps null: false
    end
  end
end
