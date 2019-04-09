class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|

      t.string :title
      t.text :body
      t.jsonb :body_json
      t.string :slug
      t.boolean :public
      t.datetime :published_at
      t.integer :user_id

      t.timestamps

      t.index :user_id
    end
  end
end
