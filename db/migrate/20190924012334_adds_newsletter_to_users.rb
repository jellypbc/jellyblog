class AddsNewsletterToUsers < ActiveRecord::Migration[6.0]
  def change
  	add_column :users, :newsletter_signed_up_at, :datetime
  end
end
