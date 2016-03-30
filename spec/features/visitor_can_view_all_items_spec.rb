require "rails_helper"

RSpec.feature "Visitor can view all items" do
  scenario "they see all items" do
    create_roles
    create_categories
    store = approved_store(store_admin)
    item = item3(store)

    visit root_path
    click_on "Items"
    expect(current_path).to eq(items_path)
    expect(page).to have_content "#{item.title}"
    expect(page).to have_content "$8.00"
    expect(page).to have_button "Add to Cart"

    click_on "#{item.title}"
    expect(current_path).to eq(store_item_path(item.store.slug, item.id))
    expect(page).to have_content "#{store.name}"
  end
end
