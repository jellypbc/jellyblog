class AddProjectIdToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :project_id, :integer

    add_index :posts, :project_id
  end
end
