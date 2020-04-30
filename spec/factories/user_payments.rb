# frozen_string_literal: true

# == Schema Information
#
# Table name: user_payments
#
#  id             :bigint           not null, primary key
#  currency       :string           not null
#  payment_method :integer          not null
#  price          :decimal(10, 2)   not null
#  purchased_at   :datetime         not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_user_payments_on_user_id  (user_id)
#
FactoryBot.define do
  factory :user_payment do
    association :user, strategy: :build
    payment_method { 1 }
    currency { 'TWD' }
    price { '9.99' }
    purchased_at { DateTime.current }
  end
end
