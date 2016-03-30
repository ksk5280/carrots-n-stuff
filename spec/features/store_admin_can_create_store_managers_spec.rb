require 'rails_helper'

RSpec.feature "store admin can create new store managers" do
  scenario "store admin sees new store manager on dashboard" do
    create_roles
    user = store_admin
    store = approved_store(user)
    reg_user = registered_user

    login(reg_user)

    click_on "Store Admin Information"

    click_on "Create New Manager"
    fill_in "Username", with: "brutal_kimi"
    fill_in "Password", with: "password"
    fill_in "First name", with: "Kimi"
    fill_in "Last name", with: "Killa"
    fill_in "Address", with:  "Planet Earth"
    fill_in "Email", with: "brutal_kimi@hotmail.com"
    click_on "Create Manager"

    expect(current_path).to eq dashboard_path
    expect(page).to have_content "Kimi Killa"
  end
end
