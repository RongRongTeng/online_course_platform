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
RSpec.describe Course, type: :model do
  let(:course) { build :course }

  describe '#for_sale?' do
    subject { course.for_sale? }

    context 'course is for sale' do
      it { is_expected.to be_truthy }
    end

    context 'course sale is closed' do
      let(:course) { build :course, :closed }

      it { is_expected.to be_falsey }
    end
  end

  describe '#expiry_day' do
    subject { course.expiry_day }

    it { is_expected.to eq 1.day }
  end
end
