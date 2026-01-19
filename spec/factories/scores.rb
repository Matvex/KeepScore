FactoryBot.define do
  factory :score do
    association :game_session
    player_name { game_session.name1 }
    won { true }
    
    trait :won_game do
      won { true }
    end
    
    trait :lost_game do
      won { false }
    end
  end
end
