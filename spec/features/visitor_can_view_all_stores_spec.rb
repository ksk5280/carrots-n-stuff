require "rails_helper"

RSpec.feature "Visitor visits store page" do
  before(:each) do
    @pending_store = Store.create(name: "Carrot Market", status: 0)
    @suspended_store = Store.create(name: "Tomato Market", status: 1)
    @approved_store = Store.create(name: "Farmer's Market", status: 2)
    create_categories
    @item = item(@approved_store)
  end

  scenario "they see stores that have an approved status" do
    visit root_path
    click_on "Markets"
    expect(current_path).to eq(stores_path)
    expect(page).to have_content "#{@approved_store.name}"
    expect(page).to_not have_content "#{@pending_store.name}"
    expect(page).to_not have_content "#{@suspended_store.name}"
  end

  context "visitor visits specific store" do
    scenario "sees items of that store" do
      visit stores_path
      click_on "#{@approved_store.name}"
      expect(current_path).to eq(store_root_path(@item.store.slug))
      expect(page).to have_content "Welcome to #{@approved_store.name}!"
      expect(page).not_to have_button "Apply for Manager position"
      expect(page).to have_content "#{@approved_store.description}"
      expect(page).to have_content "#{@item.title}"
      expect(page).to have_content "$10.00"
    end
  end
end
