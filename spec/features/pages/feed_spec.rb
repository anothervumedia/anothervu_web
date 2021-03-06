require "rails_helper"

RSpec.feature "Feed" do
  before(:each) do
    @user = FactoryBot.create(:user)
  end

  after(:each) do
    Warden.test_reset!
  end

  context "Unauthenticated user" do
    scenario "cannot see the feed and is redirected" do
      visit feed_path

      expect(page).to_not have_title("Feed | AnotherVU")
      expect(current_path).to eq(new_user_session_path)
    end
  end

  context "Authenticated user" do
    before(:each) do
      login_as(@user, scope: :user)
    end

    scenario "can see the feed" do
      visit feed_path

      expect(page).to have_title("Feed | AnotherVU")
    end

    scenario "can see projects in the feed" do
      @project = FactoryBot.create(:project_with_uploads)
      visit feed_path

      expect(page).to have_content(@project.name)
    end

    scenario "can see the most popular projects first" do
      @projectA = FactoryBot.create(:project_with_uploads, name: "Project A", hearts_count: 0)
      @projectB = FactoryBot.create(:project_with_uploads, name: "Project B", hearts_count: 5)
      @projectC = FactoryBot.create(:project_with_uploads, name: "Project C", hearts_count: 3)
      visit feed_path

      projects = all('.project > div > a')
      expect(projects[0].text).to eq(@projectB.name)
      expect(projects[1].text).to eq(@projectC.name)
      expect(projects[2].text).to eq(@projectA.name)
    end

    scenario "can paginate the feed" do
      15.times do |i|
        FactoryBot.create(:project_with_uploads, name: "project #{i}")
      end

      visit feed_path
      expect(page).to have_selector(".project", count: 12)

      click_on "Next"
      expect(page).to have_selector(".project", count: 3)
    end

    scenario "can heart/favorite a project", js: true do
      @project = FactoryBot.create(:project_with_uploads)
      visit feed_path

      expect(@project.hearts_count).to eq(0)
      expect(page).to_not have_css(".project .heart.favorited")

      page.find(".project:first-child .heart").click
      wait_for_ajax

      expect(@project.reload.hearts_count).to eq(1)
      expect(page).to have_css(".project:first-child .heart.favorited")
    end

    scenario "can see details of a project from the feed" do
      @project = FactoryBot.create(:project_with_uploads)

      # By clicking the name
      visit feed_path
      click_on @project.name

      expect(current_path).to eq(project_path(@project))
      expect(page).to have_content(@project.name)
      expect(page).to have_content(@project.description)

      # And by clicking the image
      visit feed_path
      page.first("a[href='/projects/#{@project.id}']").click

      expect(current_path).to eq(project_path(@project))
      expect(page).to have_content(@project.name)
      expect(page).to have_content(@project.description)
    end
  end

end
