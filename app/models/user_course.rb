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
class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :payment, class_name: 'UserPayment', foreign_key: :payment_id

  has_many :categories, through: :course

  scope :available, ->(now = DateTime.current) { where('expires_at > ? AND is_used = false', now) }

  before_create :set_expires_at

  def available?(now = DateTime.current)
    !is_used? && now < expires_at
  end

  def not_available?(now = DateTime.current)
    !available?(now)
  end

  private

  def set_expires_at
    self.expires_at = payment.purchased_at + course.expiry_day
  end
end
