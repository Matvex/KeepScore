require 'rails_helper'

RSpec.describe "GameSessions", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get game_sessions_path
      expect(response).to have_http_status(:success)
    end
  end
end
