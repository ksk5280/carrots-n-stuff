require "rails_helper"

RSpec.feature "Visitor can add items to cart" do
  scenario "they see items they added" do
    create_roles
    create_categories
    store = approved_store(store_admin)
    item = item3(store)

    visit root_path

    within ".navbar-right" do
      expect(page).to have_content "(0)"
    end

    click_button("Add to Cart", :match => :first)

    expect(page).to have_content "#{item.title} added to cart!"

    within ".navbar-right" do
      expect(page).to have_content "(1)"
      click_on "Cart"
    end

    expect(current_path).to eq(cart_path)
    expect(page).to have_content "#{item.title}"
    expect(page).to have_content "#{item.description}"
    expect(page).to have_css "img"
    expect(page).to have_content "$8.00"
  end

  context "they are not logged in and try to checkout" do
    scenario "they are redirected to login" do
      create_roles
      create_categories
      store = approved_store(store_admin)
      item = item3(store)

      visit root_path
      click_on "Add to Cart"

      within ".navbar-right" do
        expect(page).to have_content "(1)"
        click_on "Cart"
      end

      expect(current_path).to eq(cart_path)

      click_on "Checkout"

      expect(current_path).to eq(login_path)

      fill_in "Username", with: registered_user.username
      fill_in "Password", with: "password"
      click_on "Login to your account"

      expect(page).to have_content "Logged in as #{registered_user.username}"
    end
  end
end
