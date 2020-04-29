# frozen_string_literal: true

class CreateCourseCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :course_categories do |t|
      t.references :course,   null: false
      t.references :category, null: false

      t.timestamps
    end

    add_index :course_categories, %i[course_id category_id], unique: true
  end
end
