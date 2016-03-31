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

    order = Order.last
    line_item = LineItem.last

    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content("Order was successfully placed!")
    expect(page).to have_content("Cart (0)")
    expect(page).to have_content "##{order.id}"
    expect(page).to have_content item.title
    expect(page).to have_content item.description
    expect(page).to have_content "Qty. #{line_item.quantity}"
    expect(page).to have_content "Subtotal: $16.00"
    expect(page).to have_content "Total: $16.00"

    click_link "All Orders"
    within "table" do
      expect(page).to have_content "##{order.id}"
    end
  end

  context "they try to checkout without any items in cart" do
    scenario "they see error message" do
      create_roles
      create_categories
      store = approved_store(store_admin)
      item = item3(store)
      login(registered_user)

      visit root_path

      within ".navbar-right" do
        expect(page).to have_content "(0)"
        click_on "Cart"
      end

      expect(current_path).to eq(cart_path)

      click_on "Checkout"

      expect(current_path).to eq(cart_path)
      expect(page).to have_content "You can't check out with an empty cart."
    end
  end
end
