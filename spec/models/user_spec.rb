# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE)
#  authentication_token   :string(30)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

RSpec.describe User, type: :model do
  let(:user) { create :user }

  describe '#purchase_course!' do
    let(:course_one) { create :course, id: 1 }
    let(:course_two) { create :course, id: 2 }
    let!(:user_courses) do
      [
        (create :user_course, :is_used, user: user, course: course_one),
        (create :user_course, user: user, course: course_one),
        (create :user_course, :is_used, user: user, course: course_two)
      ]
    end

    subject { user.purchase_course!(course, :credit_card) }

    context 'purchases successfully' do
      let(:course) { course_two }

      it 'creates user payment in database' do
        expect { subject }.to change { UserPayment.count }.from(3).to(4)
      end

      it 'creates user course in database' do
        expect { subject }.to change { UserCourse.count }.from(3).to(4)
      end

      it 'returns user course' do
        is_expected.to be_a_kind_of(UserCourse)
      end
    end

    context 'purchases failure due to user course is available and duplicate purchased' do
      let(:course) { course_one }

      it 'raises client error ' do
        expect { subject }.to raise_error(ClientError, 'duplicate_purchased')
      end
    end
  end
end
