require "rails_helper"

RSpec.feature "Store admin can see store admin dashboard" do
  scenario "can see store admin dashboard" do
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
      expect(page).to have_content "Celery"
      expect(page).to have_content "$10.00"
  end
end
