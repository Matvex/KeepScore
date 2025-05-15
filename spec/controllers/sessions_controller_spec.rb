require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #new" do
    it "returns a successful response" do
      get :new
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    let(:user) { create(:user) }

    context "with valid credentials" do
      it "logs in the user and redirects to game_sessions_path" do
        post :create, params: { username: user.username, password: user.password }
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(game_sessions_path)
      end
    end

    context "with invalid credentials" do
      it "renders the new template with an alert" do
        post :create, params: { username: user.username, password: "wrongpassword" }
        expect(session[:user_id]).to be_nil
        expect(flash.now[:alert]).to eq("Invalid username or password")
      end
    end

    context "with development password" do
      it "logs in the user with the development password and redirects to game_sessions_path" do
        allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("development"))
        post :create, params: { username: user.username, password: "ks" }
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(game_sessions_path)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:user) { create(:user) }

    before do
      session[:user_id] = user.id
    end

    it "logs out the user and redirects to root_path" do
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(root_path)
    end
  end
end
