require "rails_helper"

RSpec.feature "Visitor visits store page" do
  scenario "they see stores that have an approved status" do
    pending_store = Store.create(name: "Carrot Market", status: 0)
    suspended_store = Store.create(name: "Tomato Market", status: 1)
    approved_store = Store.create(name: "Farmer's Market", status: 2)
    category = Category.create(title: "food", id: 1000)
    item = approved_store.items.create(title: "carrots", description: "tasty", price: 999, categories: [category], id: 1001)

    visit root_path
    click_on "All Stores"
    expect(current_path).to eq(stores_path)
    expect(page).to have_content "#{approved_store.name}"
    expect(page).to_not have_content "#{pending_store.name}"
    expect(page).to_not have_content "#{suspended_store.name}"

    click_on "#{approved_store.name}"
    expect(current_path).to eq(store_root_path(item.store.slug))
    expect(page).to have_content "#{approved_store.name}"
    expect(page).to have_content "#{approved_store.description}"
    expect(page).to have_content "#{item.title}"
  end
end
