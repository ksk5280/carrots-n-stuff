require "rails_helper"

RSpec.feature "Pending store owner can create items" do
  scenario "they see items created in dashboard but are not visible to shoppers" do
    create_roles
    create_categories
    admin = store_admin
    pending_store(admin)
    login(admin)

    visit "/dashboard"

    create_item("New Strange Item")

    expect(current_path).to eq("/dashboard")

    expect(page).to have_content "New Strange Item"

    visit "/items"

    expect(page).to_not have_content "New Strange Item"
  end
end
