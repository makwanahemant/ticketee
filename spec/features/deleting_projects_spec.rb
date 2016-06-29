require 'rails_helper'

RSpec.feature 'User deleting the projects' do
  scenario "when user deleting project" do
    FactoryGirl.create(:project, name: "Sublime Text 3")

    visit '/'
    click_link "Sublime Text 3"
    click_link "Delete"

    expect(page).to have_content "Project has been deleted."
  end
end

