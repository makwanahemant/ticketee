require 'rails_helper'

RSpec.describe TicketPolicy do

  context "permissions" do
    subject { TicketPolicy.new(user, ticket) }

    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project) }
    let(:ticket) { FactoryGirl.create(:ticket, project: project, author: user) }

    context "for anonymous users" do
      let(:user) { nil }
      
      it { should_not permit_action :show }
    end

    context "for viewers of the project" do
     before do
       assign_role!(user, :viewer, project)
      end

      it { should permit_action :show}
    end
    
    context "for editor of the project" do
      before { assign_role!(user, :editor, project) }

      it { should permit_action :show}
    end

    context "for manager of the project" do
      before { assign_role!(user, :manager, project) }

      it { should permit_action :show}
    end

    context "for manager of other project" do
    before { assign_role!(user, :manager, FactoryGirl.create(:project)) }

      it { should_not permit_action :show}
    end
   
    context "for admin of the project" do
      let(:user) { FactoryGirl.create(:user, :admin) }

      it { should permit_action :show}
    end 
  end
end
