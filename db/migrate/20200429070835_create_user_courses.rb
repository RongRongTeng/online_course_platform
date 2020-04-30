# frozen_string_literal: true

class CreateUserCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :user_courses do |t|
      t.references :user, null: false
      t.references :course, null: false
      t.references :payment, null: false
      t.datetime :expires_at, null: false
      t.boolean :is_used, null: false, default: false

      t.timestamps
    end

    add_index :user_courses, %i[expires_at is_used]
  end
end
