require 'rails_helper'

RSpec.describe ScoresController, type: :controller do
  let(:user) { create(:user) }
  let!(:game_session) { create(:game_session, user: user) }

  before do
    session[:user_id] = user.id
  end

  describe "GET #index" do
    context "when game_session_id param is present" do
      it "sets session and assigns @game_session" do
        get :index, params: { game_session_id: game_session.id }
        expect(session[:last_game_session_id]).to eq(game_session.id.to_s)
        expect(assigns(:game_session)).to eq(game_session)
        expect(response).to have_http_status(:ok)
      end
    end

    context "when session[:last_game_session_id] is present" do
      before { session[:last_game_session_id] = game_session.id }

      it "assigns @game_session from session" do
        get :index
        expect(assigns(:game_session)).to eq(game_session)
        expect(response).to have_http_status(:ok)
      end
    end

    context "when no game_session_id param and no session" do
      it "assigns @game_session as nil" do
        get :index
        expect(assigns(:game_session)).to be_nil
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
