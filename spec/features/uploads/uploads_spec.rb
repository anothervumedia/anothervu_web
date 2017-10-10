require "rails_helper"

RSpec.feature "Uploads" do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  after(:each) do
    Warden.test_reset!
  end

  context "Authenticated user" do
    before(:each) do
      login_as(@user, scope: :user)
    end

    scenario "can upload an image" do
      VCR.use_cassette "upload_image" do
        visit new_upload_path

        expect(page).to have_content('New Content')

        fill_in "Name", with: "Dope Pic"
        attach_file "upload[image]", "#{Rails.root}/spec/support/images/building.jpg"
        click_on "Create"

        expect(page).to have_content "Your content was uploaded"
        expect(current_path).to eq(feed_path)
      end
    end
  end

  context "Unauthenticated user" do
    scenario "cannot upload an image" do
      visit new_upload_path
      expect(current_path).to eq(new_user_session_path)
    end
  end

end
