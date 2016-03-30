require "rails_helper"

RSpec.feature "User creates order" do
  scenario "they see success flash and order on dashboard" do
    create_roles
    create_categories
    store = approved_store(store_admin)
    item = item3(store)
    login(registered_user)

    visit root_path

    click_button "Add to Cart"
    click_button "Add to Cart"

    within ".navbar-right" do
      expect(page).to have_content "(2)"
      click_on "Cart"
    end

    expect(current_path).to eq(cart_path)
    expect(page).to have_content item.title

    click_on "Checkout"
    expect(page).to_not have_content "Delivery Status: Unrequested"
    click_on "Request Delivery"
    expect(page).to have_content "Delivery Status: Pending"
  end
end
