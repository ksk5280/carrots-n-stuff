require "rails_helper"

RSpec.feature "Visitor visits categories page" do
  scenario "sees all categories" do
    create_roles
    user = store_admin
    create_categories
    store = approved_store(user)
    item = item3(store)

    visit root_path
    click_on "Categories"
    expect(current_path).to eq(categories_path)
    expect(page).to have_content "Fruits"

    click_on "Fruits"
    expect(current_path).to eq "/categories/fruits"
    expect(page).to have_content "Fruits"
    expect(page).to have_content "#{item.title}"
    expect(page).to have_content "$8.00"
    expect(page).to have_button "Add to Cart"
  end
end
