require 'rails_helper'

RSpec.describe Score, type: :model do
  let(:user) { create(:user) }
  let(:game_session) { create(:game_session, user: user) }

  describe 'associations' do
    it 'belongs to game_session' do
      expect(Score.new).to respond_to(:game_session)
    end
    
    it 'has a game_session association' do
      score = create(:score, game_session: game_session)
      expect(score.game_session).to eq(game_session)
    end
  end

  describe 'validations' do
    it 'validates presence of player_name' do
      score = build(:score, game_session: game_session, player_name: nil)
      expect(score).not_to be_valid
      expect(score.errors[:player_name]).to be_present
    end

    it 'validates presence of won' do
      score = build(:score, game_session: game_session, won: nil)
      expect(score).not_to be_valid
      expect(score.errors[:won]).to be_present
    end

    it 'validates presence of game_session_id' do
      score = build(:score, game_session_id: nil)
      expect(score).not_to be_valid
      expect(score.errors[:game_session_id]).to be_present
    end
  end

  describe '#points' do
    context 'when player won' do
      let(:score) { create(:score, game_session: game_session, won: true) }

      it 'returns 1' do
        expect(score.points).to eq(1)
      end
    end

    context 'when player lost' do
      let(:score) { create(:score, game_session: game_session, won: false) }

      it 'returns -2' do
        expect(score.points).to eq(-2)
      end
    end
  end
end
