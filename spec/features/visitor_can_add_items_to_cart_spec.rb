require "rails_helper"

RSpec.feature "Visitor can add items to cart" do
  scenario "they see items they added" do
    user = User.create(username: "bacon", password: "password")
    3.times{create(:role)}
    user.roles << Role.find_by(name: "registered_user")
    user.roles << Role.find_by(name: "store_admin")
    store = user.stores.create(name: "Farmer's Market")
    store.status = 2
    category = Category.create(title: "food", id: 1000)
    item = store.items.create(title: "carrots", description: "tasty", price: 999, categories: [category], id: 1001)

    visit root_path

    within ".navbar-right" do
      expect(page).to have_content "(0)"
    end

    click_on "Add to Cart"

    expect(page).to have_content "#{item.title} added to cart!"

    within ".navbar-right" do
      expect(page).to have_content "(1)"
      click_on "Cart"
    end

    expect(current_path).to eq(cart_path)
    expect(page).to have_content "#{item.title}"
    expect(page).to have_content "#{item.description}"
    expect(page).to have_css "img"
    expect(page).to have_content "$9.99"
  end
end
