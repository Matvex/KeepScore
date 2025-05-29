require 'rails_helper'

RSpec.describe GameSessionsController, type: :controller do
  let(:user) { create(:user) }
  let!(:game_session) { create(:game_session, user: user) }

  before do
    session[:user_id] = user.id
  end

  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_params) do
        {
          game_session: {
            name1: "Alice",
            name2: "Bob",
            name3: "Charlie",
            name4: "Diana"
          }
        }
      end

      it "creates a new game session and redirects to scores" do
        expect {
          post :create, params: valid_params
        }.to change(GameSession, :count).by(1)
        expect(response).to redirect_to(scores_path(game_session_id: GameSession.last.id))
      end
    end

    context "with invalid params" do
      let(:invalid_params) do
        {
          game_session: {
            name1: "",
            name2: "",
            name3: "",
            name4: ""
          }
        }
      end

      it "does not create a game session and re-renders index" do
        expect {
          post :create, params: invalid_params
        }.not_to change(GameSession, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:index)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the game session and redirects to index" do
      expect {
        delete :destroy, params: { id: game_session.id }
      }.to change(GameSession, :count).by(-1)
      expect(response).to redirect_to(game_sessions_path)
    end
  end
end
