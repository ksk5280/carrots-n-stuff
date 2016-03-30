require "rails_helper"

RSpec.feature "store admin can approve drone strike" do
  scenario "can see drone status" do
    create_roles
    user = store_admin

    store = pending_store(user)

    create_categories

    item2(store)

    order = Order.create(user_id: user.id, status: "paid", drone: 1)

    login(user)

    expect(current_path).to eq("/dashboard")

    click_on "Store Admin Information"

    expect(page).to have_content "##{order.id}"
    expect(page).to have_content "Carrots"
    expect(page).to have_content "$5.00"
    expect(page).to have_content "Pending"

    click_on "Confirm"
    visit "/dashboard"
    click_on "Store Admin Information"

      expect(page).to have_content "Completed"
      expect(page).to_not have_content "Decline"
      expect(page).to_not have_content "Confirm"
  end
end
