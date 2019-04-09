class CreateProjectOwnerships < ActiveRecord::Migration[6.0]
  def change
    create_table :project_ownerships do |t|

      t.integer :project_id
      t.integer :user_id
      
      t.timestamps
    end
  end
end
