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

      expect(page).to have_content('New Project')

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
  end

  context "Unauthenticated user" do
    scenario "cannot create a project" do
      visit new_project_path
      expect(current_path).to eq(new_user_session_path)
    end
  end

end
