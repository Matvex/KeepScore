# == Schema Information
#
# Table name: scores
#
#  id               :integer          not null, primary key
#  game_session_id  :integer          not null
#  player_name      :string(16)       not null
#  won              :boolean          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Score < ApplicationRecord
  belongs_to :game_session

  validates :player_name, presence: true
  validates :won, inclusion: { in: [true, false] }
  validates :game_session_id, presence: true

  def points
    won ? 1 : -2
  end
end
