require 'rails_helper'

RSpec.feature "GameSessions", type: :feature do
  let(:user) { create(:user, password: "password") }

  before do
    # Log in as the user
    visit new_session_path
    fill_in "Username", with: user.username
    fill_in "Password", with: "password"
    click_button "Login"
  end

  scenario "User sees their game sessions" do
    create(:game_session, user: user, name1: "Alice", name2: "Bob", name3: "Charlie", name4: "Diana")
    visit game_sessions_path
    within ".game-session-list" do
      expect(page).to have_selector(".game-session-item", text: "Alice")
      expect(page).to have_selector(".game-session-item", text: "Bob")
      expect(page).to have_selector(".game-session-item", text: "Charlie")
      expect(page).to have_selector(".game-session-item", text: "Diana")
    end
  end

  scenario "User creates a new game session" do
    visit game_sessions_path
    click_button "New Game Session"
    fill_in "Name1", with: "Eve"
    fill_in "Name2", with: "Frank"
    fill_in "Name3", with: "Grace"
    fill_in "Name4", with: "Heidi"
    click_button "Create Game Session"
    expect(page).to have_content("Eve")
    expect(page).to have_content("Frank")
    expect(page).to have_content("Grace")
    expect(page).to have_content("Heidi")
  end
end
