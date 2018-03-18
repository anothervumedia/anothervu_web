require "rails_helper"

RSpec.feature "Projects" do
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

    scenario "can create a project" do
      visit new_project_path

      expect(page).to have_content('First, describe your project.')

      fill_in "Name", with: "Dope Pic"
      fill_in "Description", with: "This is picture is beyond cool. It was taken in the Spring of 1999."
      click_on "Save"

      expect(page).to have_content "Your project was created"
      expect(current_path).to eq(project_path(Project.last))
    end

    scenario "can see a list of their projects" do
      @project = FactoryGirl.create(:project, user: @user)
      @project2 = FactoryGirl.create(:project, name: "Glass Bldg", user: @user)
      visit projects_path

      expect(page).to have_content(@project.name)
      expect(page).to have_content(@project2.name)
    end

    scenario "can edit a project" do
      @project = FactoryGirl.create(:project, user: @user)
      visit projects_path

      expect(page).to have_content(@project.name)

      click_on "Edit"

      expect(current_path).to eq(edit_project_path(@project.id))

      fill_in "Name", with: "My Updated Name"
      click_on "Save"

      expect(current_path).to eq(projects_path)
      expect(page).to have_content("My Updated Name")
    end

    scenario "can delete a project" do
      @project = FactoryGirl.create(:project, user: @user)
      visit projects_path

      expect(page).to have_content(@project.name)
      expect(Project.count).to eq(1)

      click_on "Delete"

      expect(page).to_not have_content(@project.name)
      expect(Project.count).to eq(0)
    end

    scenario "can view a project and favorite it", js: true do
      @project = FactoryGirl.create(:project_with_uploads)
      visit project_path(@project)

      expect(@project.hearts_count).to eq(0)
      expect(page).to_not have_css(".project-heart.favorited")

      page.find(".project-heart").click
      wait_for_ajax

      expect(@project.reload.hearts_count).to eq(1)
      expect(page).to have_css(".project-heart.favorited")
    end

    scenario "can navigate to a project creators profile" do
      @project = FactoryGirl.create(:project_with_uploads)
      visit project_path(@project)

      click_on "#{@project.user.first_name} #{@project.user.last_name}"

      expect(current_path).to eq(user_path(@project.user))
    end

    scenario "cannot edit another user's project" do
      @another_user = FactoryGirl.create(:user, first_name: "Joe", last_name: "Rogan")
      @another_user_project = FactoryGirl.create(:project_with_uploads, user: @another_user)

      visit edit_project_path(@another_user_project)
      
      expect(page).to have_content("You are not authorized to perform this action.")
      expect(current_path).to eq(feed_path)
    end

    scenario "cannot destroy another user's project" do
      @another_user = FactoryGirl.create(:user, first_name: "Joe", last_name: "Rogan")
      @another_user_project = FactoryGirl.create(:project_with_uploads, user: @another_user)

      page.driver.submit :delete, "/projects/#{@another_user_project.id}", {}
      
      expect(page).to have_content("You are not authorized to perform this action.")
      expect(current_path).to eq(feed_path)
    end

  end

  context "Unauthenticated user" do
    scenario "cannot create a project" do
      visit new_project_path
      expect(current_path).to eq(new_user_session_path)
    end
  end

end
