require "rails_helper"

RSpec.feature "user can create a store" do
  context "user logs in and clicks create new store" do
    scenario "sees user dashboard page with new store listed" do
      user = create(:user)
      visit "/"
      first(:link, "Login").click
      fill_in "Username", with: user.username
      fill_in "Password", with: "password"
      click_button "Login"

      expect(current_path).to eq "/dashboard"
      click_on "Create new store"
      fill_in "Name", with: "Mod Farmers"
      click_button "Create store"
      expect(current_path).to eq "/dashboard"
      expect(page).to have_content("Mod Farmers")

      click_on "Update store"
      fill_in "Name", with: "Modern Farmers"
      click_button "Update store"
      expect(current_path).to eq "/dashboard"
      expect(page).to have_content("Modern Farmers")

    end
  end
end
