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
class Course < ApplicationRecord
  validates_presence_of :title, :url, :currency, :price,
                        :starts_at, :ends_at, :expiry_period
  validates_numericality_of :expiry_period, greater_than_or_equal_to: 1, less_than_or_equal_to: 30

  has_many :course_categories, dependent: :destroy
  has_many :categories, through: :course_categories

  scope :for_sale, ->(now = DateTime.current) { where('starts_at <= ? AND ends_at > ?', now, now) }

  def for_sale?
    now = DateTime.current
    now >= starts_at && ends_at > now
  end

  def expiry_day
    expiry_period.day
  end
end
