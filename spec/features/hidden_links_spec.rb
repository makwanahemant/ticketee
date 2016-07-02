require 'rails_helper'

RSpec.feature "User can see only relevent links" do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:project) { FactoryGirl.create(:project) }

  before do 
    login_as(user)
    assign_role!(user, :viewer, project)
  end

  context "anonymous users" do
    scenario 'cannot see the New Project link' do
      visit '/'
      expect(page).not_to have_link "New Project"
    end
    scenario 'cannot see the Delete link' do
      visit project_path(project)
      expect(page).not_to have_link "Delete Project"
    end
  end

  context 'regular users' do
    before { login_as(user) }

    scenario 'cannot see the New Project link' do
      visit '/'
      expect(page).not_to have_link "New Project"
    end

    scenario 'cannot see the Edit Project link' do
      visit project_path(project)
      expect(page).not_to have_link "Edit Project"
    end

    scenario 'cannot see the Delete Project link' do
      visit project_path(project)

      expect(page).not_to have_link "Delete Project"
    end
  end

  context 'admin users' do
    before { login_as(admin) }

    scenario 'can see the New Project link' do
      visit '/'
      expect(page).to have_link "New Project"
    end

    scenario 'can see the Delete Project link' do

      visit project_path(project)
      expect(page).to have_link "Delete Project"
    end
  end


end

