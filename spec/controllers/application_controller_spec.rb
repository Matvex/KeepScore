require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    before_action :authenticate_user!, only: :restricted_action

    def restricted_action
      render plain: "Restricted content"
    end
  end

  before do
    routes.draw { get "restricted_action" => "anonymous#restricted_action" }
  end

  describe "#current_user" do
    let(:user) { create(:user) }

    it "returns the current user if session user_id is set" do
      session[:user_id] = user.id
      expect(subject.send(:current_user)).to eq(user)
    end

    it "returns nil if session user_id is not set" do
      session[:user_id] = nil
      expect(subject.send(:current_user)).to be_nil
    end
  end

  describe "#authenticate_user!" do
    context "when user is not authenticated" do
      it "redirects to the new session path" do
        get :restricted_action
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "when user is authenticated" do
      let(:user) { create(:user) }

      it "allows access to the restricted action" do
        session[:user_id] = user.id
        get :restricted_action
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq("Restricted content")
      end
    end
  end

  describe "#user_signed_in?" do
    let(:user) { create(:user) }

    it "returns true if there is a current user" do
      session[:user_id] = user.id
      expect(subject.send(:user_signed_in?)).to be_truthy
    end

    it "returns false if there is no current user" do
      session[:user_id] = nil
      expect(subject.send(:user_signed_in?)).to be_falsey
    end
  end
end