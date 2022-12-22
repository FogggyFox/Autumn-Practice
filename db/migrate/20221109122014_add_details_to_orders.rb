class AddDetailsToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :user, foreign_key: true, null: true
  end
end
