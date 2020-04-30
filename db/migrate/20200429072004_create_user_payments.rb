# frozen_string_literal: true

class CreateUserPayments < ActiveRecord::Migration[5.2]
  def change
    create_table :user_payments do |t|
      t.references :user, null: false
      t.integer :payment_method, null: false
      t.string :currency, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.datetime :purchased_at, null: false

      t.timestamps
    end
  end
end
