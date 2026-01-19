# == Schema Information
#
# Table name: game_sessions
#
#  id             :integer          not null, primary key
#  user_id        :integer          not null
#  name1          :string(16)
#  name2          :string(16)
#  name3          :string(16)
#  name4          :string(16)
#  total_points1  :bigint           default(0), not null
#  total_points2  :bigint           default(0), not null
#  total_points3  :bigint           default(0), not null
#  total_points4  :bigint           default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class GameSession < ApplicationRecord
  belongs_to :user
  has_many :scores, dependent: :destroy

  validates :name1, :name2, :name3, :name4, presence: true
  validate :names_are_unique

  private

  def names_are_unique
    names = [ name1, name2, name3, name4 ].map { |n| n.to_s.strip.downcase }.reject(&:blank?)
    if names.uniq.length != names.length
      errors.add(:base, I18n.t("game_sessions.errors.names_must_be_unique"))
    end
  end
end
