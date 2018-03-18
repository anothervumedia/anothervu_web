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

    # TODO: need to ignore request - but ONLY for this scenario
    # https://github.com/vcr/vcr/issues/229
    xscenario "can upload an image", js: true do
      VCR.use_cassette "upload_image" do
        visit new_project_path

        expect(page).to have_content('New Project')

        fill_in "Name", with: "Dope Pic"
        fill_in "Description", with: "This is picture is beyond cool. It was taken in the Spring of 1999."
        click_on "Add Image"
        find(:xpath, ".//input[@type='file']").set("#{Rails.root}/spec/support/images/building.jpg")
        click_on "Save"

        expect(page).to have_content "Your project was created."
        expect(Upload.count).to eq(1)
        expect(current_path).to eq(project_path(Project.last))
      end
    end
  end

  context "Unauthenticated user" do
    scenario "cannot upload an image" do
      visit new_project_path
      expect(current_path).to eq(new_user_session_path)
    end
  end

end
