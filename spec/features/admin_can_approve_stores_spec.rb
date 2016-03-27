require "rails_helper"

RSpec.feature "platform admin can approve a pending store" do
  scenario "can approve pending store" do
    user = User.create(username: "bacon", password: "password")
    3.times{create(:role)}
    user.roles << Role.find_by(name: "registered_user")
    user.roles << Role.find_by(name: "store_admin")
    user.roles << Role.find_by(name: "platform_admin")
    store = user.stores.create(name: "Farmer's Market")
    store.status = 0

    visit "/login"
    fill_in "Username", with: "bacon"
    fill_in "Password", with: "password"
    click_on "Login to your account"

    visit "/dashboard"
    click_on "Platform Admin Information"

    expect(page).to have_content "Farmer's Market"
    expect(page).to have_content "Pending"
    click_on "Approve"
    expect(page).to have_content "Approved"

    visit "/farmer-s-market"
    expect(current_path).to eq("/farmer-s-market")
  end
end
