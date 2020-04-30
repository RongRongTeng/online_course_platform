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
require 'rails_helper'

RSpec.describe UserCourse, type: :model do
  let(:user_course) { create :user_course }

  describe '#create' do
    subject { user_course }

    it 'creates user course record in database' do
      expect { subject }.to change { UserCourse.count }.from(0).to(1)
    end

    context 'before create callback' do
      let(:payment) { create :user_payment, purchased_at: DateTime.new(2020, 4, 30, 12, 0, 0) }
      let(:course) { create :course, expiry_period: 2 }
      let(:user_course) { create :user_course, course: course, payment: payment }

      it 'sets expires at' do
        subject
        expect(user_course.expires_at).to eq DateTime.new(2020, 5, 2, 12, 0, 0)
      end
    end
  end

  describe '#available?' do
    subject { user_course.available? }

    context 'not used and is not expired' do
      it { is_expected.to be_truthy }
    end

    context 'not used but is expired' do
      let(:now) { DateTime.current + 2.month }

      subject { user_course.available?(now) }

      it { is_expected.to be_falsy }
    end

    context 'is used and is expired' do
      let(:user_course) { create :user_course, :is_used }
      let(:now) { DateTime.current + 2.month }

      subject { user_course.available?(now) }

      it { is_expected.to be_falsy }
    end

    context 'is used but is not expired' do
      let(:user_course) { create :user_course, :is_used }

      it { is_expected.to be_falsy }
    end
  end

  describe '#not_available?' do
    before { allow(user_course).to receive(:available?).and_return(available) }

    subject { user_course.not_available? }

    context 'is available' do
      let(:available) { true }

      it { is_expected.to be_falsy }
    end

    context 'is not available' do
      let(:available) { false }

      it { is_expected.to be_truthy }
    end
  end
end
