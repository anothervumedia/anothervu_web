require "rails_helper"

RSpec.feature "Signing In", :devise do
  before(:each) do
    @user = FactoryBot.create(:user)
  end

  # Chrome doesn't seem to be filling in the pw field so this is failing
  scenario "signing in with valid credentials", js: true do
    signin(@user.email, @user.password)

    expect(current_path).to eq(feed_path)
    expect(page).to have_title("Feed | AnotherVU")
  end

  scenario "signing in with invalid credentials", js: true do
    signin(@user.email, 'hackersRcoming')

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content("Invalid Email or password")
  end

end
