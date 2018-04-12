require "rails_helper"

RSpec.feature "Home page" do
  scenario "visit the home page" do
    visit home_path
    expect(page).to have_content("AnotherVU")
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Sign In")
    expect(page).to have_content("What's the story in architecture and design news? You are.")
    expect(page).to have_content("About")
    expect(page).to have_content("Terms and Conditions")
    expect(page).to have_content("Privacy Policy")
    expect(page).to have_content("Contact")
  end
end
