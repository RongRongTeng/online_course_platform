# frozen_string_literal: true

RSpec.describe 'Admin::Courses', type: :request do
  describe 'GET /admin/courses' do
    subject { get admin_courses_path }

    it_behaves_like 'admin zone'
  end
end
