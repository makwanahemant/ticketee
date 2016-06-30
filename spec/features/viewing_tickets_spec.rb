require 'rails_helper'

RSpec.feature 'Viewing Project tickets' do

   before do
     author = FactoryGirl.create(:user)

     sublime = FactoryGirl.create(:project, name: "Sublime Text 3")
     FactoryGirl.create(:ticket, project: sublime, name: "Make it shiny!",
                        author: author, description: "Gradients! Starbursts! oh my!")

     ie  = FactoryGirl.create(:project, name: "Internet Explorer")
     FactoryGirl.create(:ticket, project: ie, name: "Standard compliance",
                        author: author, description: "Isn't a joke.")

     visit '/'
   end

   scenario 'for a given project' do
     click_link "Sublime Text 3"

     expect(page).to have_content "Make it shiny!"
     expect(page).to_not have_content "Standard compliance"

     click_link "Make it shiny!"
     within("#ticket h2") do
       expect(page).to have_content "Make it shiny!"
     end
     expect(page).to have_content "Gradients! Starbursts! oh my!"
   end


end

