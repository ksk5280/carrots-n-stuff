require "rails_helper"

RSpec.feature "user can create a store" do
  context "user logs in and clicks create new store" do
    scenario "sees user dashboard page with new store" do
      create_roles
      user = registered_user

      login(user)

      expect(current_path).to eq "/dashboard"
      click_on "Create new store"
      click_on "Submit"
      expect(page).to have_content "Name can't be blank"
      visit "/dashboard"

      create_store(user)
      expect(current_path).to eq "/dashboard"
      expect(page).to have_content "Store successfully requested."

      click_on "Store Admin Information"
      expect(page).to have_content "#{user.first_name}'s Market"
      expect(page).to have_content "Status: Pending"

      click_on "Update store"
      fill_in "Name", with: ""
      fill_in "Description", with: ""
      click_on "Submit"

      expect(page).to have_content "Name can't be blank"
    end
  end
end
