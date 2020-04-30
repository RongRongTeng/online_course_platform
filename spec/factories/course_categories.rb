# frozen_string_literal: true

# == Schema Information
#
# Table name: course_categories
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  course_id   :bigint           not null
#
# Indexes
#
#  index_course_categories_on_category_id                (category_id)
#  index_course_categories_on_course_id                  (course_id)
#  index_course_categories_on_course_id_and_category_id  (course_id,category_id) UNIQUE
#
FactoryBot.define do
  factory :course_category do
    association :course, strategy: :build
    association :category, strategy: :build
  end
end
