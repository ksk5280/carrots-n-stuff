require "rails_helper"

RSpec.feature "Visitor can adjust cart quantity" do
  before(:each) do
    create_categories
    create_roles
    store = approved_store(store_admin)
    @item = item3(store)

    visit "/items"
    click_on "Add to Cart"
    click_link "Cart"
  end

  scenario "they can add additional items to the cart" do
    within(".cart-items") do
      expect(page).to have_content @item.title
      expect(page).to have_content format_price(@item.price)
      expect(page).to have_content("Qty. 1")
    end

    click_on "Increase quantity"

    expect(current_path).to eq("/cart")

    within(".cart-items") do
      expect(page).to have_content @item.title
      expect(page).to have_content("Qty. 2")
    end

  end

  scenario "they can remove items from the cart" do
    visit "/items"
    click_on "Add to Cart"
    click_link "Cart"
    visit "/cart"

    within(".cart-items") do
      expect(page).to have_content("Qty. 2")
    end

    click_on "Decrease quantity"

    expect(current_path).to eq(cart_path)

    within(".cart-items") do
      expect(page).to have_content @item.title
      expect(page).to have_content format_price(@item.price)
      expect(page).to have_content("Qty. 1")
    end

  end

  context "they decrease quantity to zero" do
    scenario "they see the item removed from the cart" do
      within(".cart-items") do
        expect(page).to have_content("Qty. 1")
      end

      click_on "Decrease quantity"

      within(".cart-items") do
        expect(page).not_to have_content @item.title
        expect(page).not_to have_content format_price(@item.price)
        expect(page).not_to have_content("Qty. 1")
      end

      expect(page).to have_content("#{@item.title} removed from cart!")
    end
  end

  context "they remove item from cart" do
    scenario "they don't see the item in the cart anymore" do
      within(".cart-items") do
        expect(page).to have_content("Qty. 1")
      end

      click_on "Remove"

      within(".cart-items") do
        expect(page).not_to have_content @item.title
        expect(page).not_to have_content format_price(@item.price)
        expect(page).not_to have_content("Qty. 1")
      end

      expect(page).to have_content("Successfully removed #{@item.title} from your cart.")
    end
  end

end
