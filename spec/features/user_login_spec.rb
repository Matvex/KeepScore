# spec/features/user_login_spec.rb
require 'rails_helper'

RSpec.feature "UserLogin", type: :feature do
  let(:user) { create(:user) }

  scenario "User logs in with valid credentials" do
    visit new_session_path
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Login"

    expect(page).to have_content("GameSessions")
  end

  scenario "User logs in with invalid credentials" do
    visit new_session_path
    fill_in "Username", with: user.username
    fill_in "Password", with: "wrongpassword"
    click_button "Login"

    expect(page).to have_content("Invalid username or password")
  end
end
