# frozen_string_literal: true

# == Schema Information
#
# Table name: user_courses
#
#  id         :bigint           not null, primary key
#  expires_at :datetime         not null
#  is_used    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :bigint           not null
#  payment_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_courses_on_course_id               (course_id)
#  index_user_courses_on_expires_at_and_is_used  (expires_at,is_used)
#  index_user_courses_on_payment_id              (payment_id)
#  index_user_courses_on_user_id                 (user_id)
#
FactoryBot.define do
  factory :user_course do
    association :user, strategy: :build
    association :course, strategy: :build
    association :payment, factory: :user_payment, strategy: :build
    is_used { false }

    trait :is_used do
      is_used { true }
    end
  end
end
