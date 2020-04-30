# frozen_string_literal: true

RSpec.describe UserCourseQuery, type: :query do
  let(:query) { described_class.new(user_courses, params) }
  let(:course_one) { create :course, :with_categories }
  let(:course_two) { create :course, :with_categories, category_ids: [2, 4] }
  let(:user_courses) do
    [
      (create :user_course, course: course_one),
      (create :user_course, :is_used, course: course_two)
    ]
  end

  describe '#execute' do
    subject { query.execute }

    context 'with no params' do
      before do
        allow(query).to receive(:available_condition)
        allow(query).to receive(:category_condition)
      end

      let(:params) { {} }

      it 'retrieves all input user courses' do
        is_expected.to eq user_courses
      end

      it 'does not invoke query condition' do
        subject
        expect(query).to_not receive(:available_condition)
        expect(query).to_not receive(:category_condition)
      end
    end

    context 'with available param only' do
      let(:params) do
        { available: available }
      end

      context 'is available' do
        let(:available) { true }

        it 'retrieves filtered user courses' do
          is_expected.to eq [user_courses[0]]
        end
      end

      context 'is not available' do
        let(:available) { false }

        it 'retrieves filtered user courses' do
          is_expected.to eq [user_courses[1]]
        end
      end

      context 'is available with specific time' do
        let(:available) { true }
        let(:now) { DateTime.current + 2.month }
        let(:query) { described_class.new(user_courses, params, now) }

        it 'retrieves filtered user courses' do
          is_expected.to eq []
        end
      end
    end

    context 'with category_id param only' do
      let(:params) do
        { category_id: category_id }
      end

      context 'category id is 1' do
        let(:category_id) { 1 }

        it 'retrieves filtered user courses' do
          is_expected.to eq [user_courses[0]]
        end
      end

      context 'category id is 2' do
        let(:category_id) { 2 }

        it 'retrieves filtered user courses' do
          is_expected.to eq user_courses
        end
      end
    end

    context 'with both available and category_id params' do
      let(:params) do
        {
          available: available,
          category_id: category_id
        }
      end

      context 'user course is not available and category id is 1' do
        let(:available) { false }
        let(:category_id) { 1 }

        it 'retrieves filtered user courses' do
          is_expected.to eq []
        end
      end

      context 'user course is available and category id is 1' do
        let(:available) { true }
        let(:category_id) { 1 }

        it 'retrieves filtered user courses' do
          is_expected.to eq [user_courses[0]]
        end
      end
    end
  end
end
