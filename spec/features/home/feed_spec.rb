require "rails_helper"

RSpec.feature "Feed" do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  after(:each) do
    Warden.test_reset!
  end

  context "Unauthenticated user" do
    scenario "cannot see the feed and is redirected" do
      visit feed_path

      expect(page).to_not have_content("Feed")
      expect(current_path).to eq(new_user_session_path)
    end
  end

  context "Authenticated user" do
    before(:each) do
      login_as(@user, scope: :user)
    end

    scenario "can see the feed" do
      visit feed_path

      expect(page).to have_content("Feed")
    end

    scenario "can see uploads in the feed" do
      @upload = FactoryGirl.create(:upload)
      visit feed_path

      expect(page).to have_content(@upload.name)
    end

    scenario "can paginate the feed" do
      15.times do |i|
        FactoryGirl.create(:upload, name: "Upload #{i}")
      end

      visit feed_path
      expect(page).to have_selector(".upload", count: 12)

      click_on "Next"
      expect(page).to have_selector(".upload", count: 3)
    end
  end

end
