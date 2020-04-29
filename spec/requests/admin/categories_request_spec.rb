# frozen_string_literal: true

RSpec.describe 'Admin::Categories', type: :request do
  describe 'GET /admin/categories' do
    subject { get admin_categories_path }

    it_behaves_like 'admin zone'
  end
end
