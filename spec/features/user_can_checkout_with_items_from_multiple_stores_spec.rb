require 'rails_helper'

RSpec.feature "User can checkout with items from multiple stores" do
  scenario "user sees confirmation for successful checkout" do
    create_roles
    user = registered_user

    user2 = store_admin
    user3 = store_admin2

    create_categories
    store = approved_store(user2)
    item_1 = item(store)
    item_2 = item2(store)

    store2 = approved_store2(user3)
    item_3 = item3(store2)
    item_4 = item4(store2)

    login(user)

    visit items_path

    within ".navbar-right" do
      expect(page).to have_content "(0)"
    end

    visit store_item_path(store.slug, item_1.id)
    click_on "Add to Cart"
    click_on "Add to Cart"

    visit store_item_path(store.slug, item_2.id)
    click_on "Add to Cart"

    visit store_item_path(store2.slug, item_3.id)
    click_on "Add to Cart"
    click_on "Add to Cart"
    click_on "Add to Cart"

    visit store_item_path(store2.slug, item_4.id)
    click_on "Add to Cart"

    within ".navbar-right" do
      expect(page).to have_content "(7)"
      click_on "Cart"
    end

    expect(current_path).to eq cart_path

    click_on "Checkout"

    expect(page).to have_content "Order was successfully placed! An email has been sent to: #{user.email}"
    expect(page).to have_content "Our drone will deliver your produce soon!"
  end
end
