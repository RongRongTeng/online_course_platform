# frozen_string_literal: true

RSpec.shared_examples 'admin zone' do
  include_context 'user_sign_in'

  let(:user) { create :user, :admin }

  it 'returns http success' do
    subject
    expect(response).to have_http_status(:success)
  end

  it 'renders template' do
    subject
    expect(response).to render_template(:index)
  end

  context 'user is not admin' do
    let(:user) { create :user }

    it 'redirects to root path' do
      subject
      expect(response).to redirect_to(root_path)
    end
  end
end

RSpec.shared_context 'user_sign_in' do
  before { sign_in(user) }
end
