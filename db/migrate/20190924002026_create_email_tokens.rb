class CreateEmailTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :email_tokens do |t|
      t.integer :user_id
      t.string :token, null: false
      t.datetime :expires_at

      t.timestamps
    end
  end
end
