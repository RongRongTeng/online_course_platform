# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string   :title, null: false
      t.text     :description
      t.string   :url, null: false
      t.string   :currency, null: false
      t.decimal  :price, precision: 10, scale: 2, null: false
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.integer  :expiry_period, null: false

      t.timestamps
    end

    add_index :courses, %i[starts_at ends_at]
  end
end
