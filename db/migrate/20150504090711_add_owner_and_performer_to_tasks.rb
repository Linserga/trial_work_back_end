class AddOwnerAndPerformerToTasks < ActiveRecord::Migration
  def change
  	add_column :tasks, :performer, :string
  end
end
