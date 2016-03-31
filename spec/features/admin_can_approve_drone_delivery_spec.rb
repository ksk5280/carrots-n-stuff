require "rails_helper"

RSpec.feature "store admin can approve drone strike" do
  scenario "can see drone status" do
    create_roles
    user = registered_user
    user2 = store_admin

    create_categories
    store = approved_store(user2)
    item_1 = item(store)

    login(user)
    visit items_path

    within ".navbar-right" do
      expect(page).to have_content "(0)"
    end

    visit store_item_path(store.slug, item_1.id)
    click_on "Add to Cart"

    within ".navbar-right" do
      expect(page).to have_content "(1)"
      click_on "Cart"
    end

    click_on "Checkout"
    click_on "Request Delivery"
    click_on "Logout"
    expect(current_path).to eq(root_path)

    login(user2)

    click_on "Store Admin Information"

    expect(page).to have_content "##{Order.first.id}"

    click_on "Confirm"
    visit "/dashboard"
    click_on "Store Admin Information"
    expect(page).to have_content "Completed"
    expect(page).to_not have_content "Decline"
    expect(page).to_not have_content "Confirm"
  end

  scenario "can see drone status" do
    create_roles
    user = registered_user
    user2 = store_admin

    create_categories
    store = approved_store(user2)
    item_1 = item(store)

    login(user)
    visit items_path

    within ".navbar-right" do
      expect(page).to have_content "(0)"
    end

    visit store_item_path(store.slug, item_1.id)
    click_on "Add to Cart"

    within ".navbar-right" do
      expect(page).to have_content "(1)"
      click_on "Cart"
    end

    click_on "Checkout"
    click_on "Request Delivery"
    click_on "Logout"
    expect(current_path).to eq(root_path)

    login(user2)

    click_on "Store Admin Information"

    expect(page).to have_content "##{Order.first.id}"

    click_on "Decline"
    visit "/dashboard"
    click_on "Store Admin Information"
    expect(page).to have_content "Rejected"
    expect(page).to_not have_content "Decline"
    expect(page).to_not have_content "Confirm"
  end

end
