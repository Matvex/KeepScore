require 'rails_helper'

RSpec.describe GameSession, type: :model do
  let(:user) { create(:user) }

  it "is valid with unique, present names" do
    session = GameSession.new(
      user: user,
      name1: "Alice",
      name2: "Bob",
      name3: "Charlie",
      name4: "Diana"
    )
    expect(session).to be_valid
  end

  it "is invalid if any name is blank" do
    session = GameSession.new(
      user: user,
      name1: "",
      name2: "Bob",
      name3: "Charlie",
      name4: "Diana"
    )
    expect(session).not_to be_valid
    expect(session.errors[:name1]).to include("can't be blank")
  end

  it "is invalid if names are not unique (case-insensitive)" do
    session = GameSession.new(
      user: user,
      name1: "Alice",
      name2: "alice",
      name3: "Charlie",
      name4: "Diana"
    )
    expect(session).not_to be_valid
    expect(session.errors[:base]).to include(I18n.t("game_sessions.errors.names_must_be_unique"))
  end

  it "is invalid if any two names are the same" do
    session = GameSession.new(
      user: user,
      name1: "Bob",
      name2: "Bob",
      name3: "Charlie",
      name4: "Diana"
    )
    expect(session).not_to be_valid
    expect(session.errors[:base]).to include(I18n.t("game_sessions.errors.names_must_be_unique"))
  end
end
