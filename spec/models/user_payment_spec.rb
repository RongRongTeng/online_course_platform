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
require 'rails_helper'

RSpec.describe UserPayment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
