require "rails_helper"

RSpec.feature "Store admin can delete items" do
  scenario "they see dashboard without deleted item" do
    create_roles
    user = store_admin

    store = approved_store(user)

    create_categories

    item2(store)

    login(user)

    within "#store-info" do
      expect(page).to have_content "Carrots"
      click_on "Delete Item"
    end

    expect(page).to have_content "Item has been successfully deleted."
    within "#store-info" do
      expect(page).not_to have_content "Carrots"
    end
  end
end
