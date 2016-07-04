require 'rails_helper'

RSpec.feature 'User can create new ticket' do
  let(:user) { FactoryGirl.create(:user) }
  
  before do
    login_as(user)
    project = FactoryGirl.create(:project, name: "FireFox")
    assign_role!(user, :editor, project)

    visit project_path(project)
    click_link "New Ticket"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Good browser option"
    fill_in "Description", with: "My Pages are looking good"

    click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created"
    within("#ticket") do
      expect(page).to have_content "Author: #{user.email}"
    end
  end

  scenario "when providing invalid attributes" do
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has not been created."
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Description can't be blank"
  end

  scenario "when providing invalid description" do

    fill_in "Name", with: "Good browser option"
    fill_in "Description", with: "This"
    click_button "Create Ticket"


    expect(page).to have_content "Ticket has not been created"
    expect(page).to have_content "Description is too short"
  end

  scenario 'with an attachement' do
    fill_in "Name", with: "Add documentation for blink tag"
    fill_in "Description", with: "The blick tag has a speed attribute"
    attach_file "File", "spec/fixtures/speed.txt"
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created."

    within("#ticket .attachment") do
      expect(page).to have_content "speed.txt"
    end
  end

end

