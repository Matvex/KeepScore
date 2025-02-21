# spec/features/language_switcher_spec.rb
require 'rails_helper'

RSpec.feature "LanguageSwitcher", type: :feature do
  scenario "User switches language from English to Latvian" do
    visit root_path

    # Ensure the initial language is English
    expect(page).to have_selector(".language-label", text: "EN")
    expect(page).to have_selector(".language-label", text: "LV")
    expect(page).to have_unchecked_field("language-switch")
    expect(page).to have_content("Users")

    # Switch to Latvian
    find("input#language-switch").click

    # Wait for the page to reload and ensure the language is switched to Latvian
    expect(page).to have_checked_field("language-switch")
    # expect(page).to have_content("Lietotāji")
  end

  scenario "User switches language from Latvian to English" do
    visit root_path(locale: :lv)

    # Ensure the initial language is Latvian
    expect(page).to have_checked_field("language-switch")
    expect(page).to have_content("Lietotāji")

    # Switch to English
    find("input#language-switch").click

    # Wait for the page to reload and ensure the language is switched to English
    expect(page).to have_unchecked_field("language-switch")
    # expect(page).to have_content("Users")
  end
end
