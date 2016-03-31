require "rails_helper"

RSpec.feature "store admin can create item" do
  scenario "can create item" do
    create_roles
    user = store_admin

    approved_store(user)

    login(user)

    create_categories

    click_on "Store Admin Information"

    within "#store-info" do
      click_on "Create item"
    end
    fill_in "Title", with: ""
    fill_in "Description", with: ""
    fill_in "Price", with: ""
    check "Fruits"
    click_on "Create Item"

    expect(page).to have_content "Title can't be blank, Description can't be blank, Price can't be blank, Price is not a number"
    visit "/dashboard"
    click_on "Store Admin Information"

    create_item("Carrots")


    expect(page).to have_content "Carrots"
    expect(page).to have_content "$10.00"
  end
end
