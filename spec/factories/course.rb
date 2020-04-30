# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id            :bigint           not null, primary key
#  currency      :string           not null
#  description   :text
#  ends_at       :datetime         not null
#  expiry_period :integer          not null
#  price         :decimal(10, 2)   not null
#  starts_at     :datetime         not null
#  title         :string           not null
#  url           :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_courses_on_starts_at_and_ends_at  (starts_at,ends_at)
#

FactoryBot.define do
  factory :course do
    sequence(:title) { |n| "title_#{n}" }
    sequence(:url) { |n| "https://url_#{n}" }
    currency { 'TWD' }
    price { 100.00 }
    starts_at { DateTime.current - 1.month }
    ends_at { DateTime.current + 1.month }
    expiry_period { 1 }

    trait :closed do
      starts_at { DateTime.current - 2.month }
      ends_at { DateTime.current - 1.month }
    end

    trait :with_categories do
      transient do
        category_ids { [1, 2] }
      end

      after(:build) do |course, evaluator|
        course.categories = evaluator.category_ids.map do |category_id|
          Category.find_by(id: category_id) || (create :category, id: category_id)
        end
      end
    end
  end
end
