require 'rails_helper'

RSpec.describe "Scores", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get scores_path
      expect(response).to have_http_status(:success)
    end
  end
end
