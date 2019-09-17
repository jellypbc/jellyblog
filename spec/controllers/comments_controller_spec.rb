require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  describe "GET #index" do
    context "when logged in as admin" do
      let(:user) { create :user, :admin }

      before { login user }      

      xit "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET #new" do
    xit "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end
