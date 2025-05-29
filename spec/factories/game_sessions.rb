FactoryBot.define do
  factory :game_session do
    association :user
    name1 { "Alice" }
    name2 { "Bob" }
    name3 { "Charlie" }
    name4 { "Diana" }
    total_points1 { 0 }
    total_points2 { 0 }
    total_points3 { 0 }
    total_points4 { 0 }
  end
end
