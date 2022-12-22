# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :name, null: false
      t.decimal :price, precision: 15, scale: 2
      t.string :raw_address, null: false
      t.string :address_kladr
      t.string :status
      t.string :key, index: true
      t.timestamps
    end
  end
end
