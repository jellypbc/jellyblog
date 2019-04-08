require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views
  let(:user) { create :user }

  describe "#show" do
    context 'when the user exists' do
      it 'renders the profile page' do
        get :show, params: { id: user.username }

        assert_response 200
        expect(response).to render_template(:show)
      end
    end
  end


  describe '#create' do
    before do
      @params = {
        first_name: 'Arya',
        last_name: 'Stark',
        username: 'aryastark',
        email: 'arya@stark.com',
        password: 'password'
      }
    end

    it 'creates the user' do
      expect {
        post :create, params: {user: @params}
      }.to change(User, :count).by(1)
    end

    it 'logs in the user' do
    end

  end

end
