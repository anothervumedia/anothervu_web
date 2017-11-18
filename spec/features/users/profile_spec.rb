require "rails_helper"

RSpec.feature "User Profile" do
  before(:each) do
    @user = FactoryGirl.create(:user, first_name: "Jimothy", last_name: "Vanderhausen")
    @another_user = FactoryGirl.create(:user, first_name: "Joe", last_name: "Rogan")
  end

  after(:each) do
    Warden.test_reset!
  end

  context "Authenticated user" do
    before(:each) do
      login_as(@user, scope: :user)
    end

    scenario "can view their own profile" do
      visit user_path(@user)

      expect(page).to have_content(@user.first_name)
      expect(page).to have_content(@user.last_name)
      expect(page).to have_content(@user.biography)
    end

    scenario "can edit their profile" do
      visit edit_user_path(@user)
      
      expect(page).to have_field("First Name", with: @user.first_name)
      expect(page).to have_field("Last Name", with: @user.last_name)
      expect(page).to have_field("Biography", with: @user.biography)

      fill_in "First Name", with: "Dwayne"
      fill_in "Last Name", with: "Johnson"
      fill_in "Biography", with: "Formerly known as 'The Rock', now a movie star."
      click_on "Save"

      expect(current_path).to eq(user_path(@user))
      @user.reload

      expect(@user.first_name).to eq("Dwayne")
      expect(@user.last_name).to eq("Johnson")
      expect(@user.biography).to eq("Formerly known as 'The Rock', now a movie star.")
    end

    scenario "can view another user's profiile" do
      visit user_path(@another_user)
      
      expect(page).to have_content("#{@another_user.first_name} #{@another_user.last_name}'s Profile")
      expect(page).to have_content(@another_user.biography)
    end

    scenario "cannot edit another user's profile" do
      visit edit_user_path(@another_user)
      
      expect(page).to have_content("You are not authorized to perform this action.")
      expect(page).to_not have_content("#{@another_user.first_name} #{@another_user.last_name}'s Profile")
      expect(page).to_not have_content(@another_user.biography)
      expect(current_path).to eq(feed_path)
    end

  end

  context "Unauthenticated user" do
    scenario "cannot view a user's profile" do
      visit user_path(@another_user)
      expect(current_path).to eq(new_user_session_path)
    end

    scenario "cannot edit a user's profile" do
      visit edit_user_path(@another_user)
      expect(current_path).to eq(new_user_session_path)
    end
  end

end
