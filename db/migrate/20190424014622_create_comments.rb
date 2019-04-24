class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user
      t.integer :commentable_id
      t.string :commentable_type
      t.string :content, limit: 1000

      t.timestamps
    end

    add_index :comments, [:commentable_id, :commentable_type]
  end
end
