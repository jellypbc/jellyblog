class RemoveProjectOwnershipsTable < ActiveRecord::Migration[6.0]
  def change
  	drop_table :project_ownerships
  end
end
