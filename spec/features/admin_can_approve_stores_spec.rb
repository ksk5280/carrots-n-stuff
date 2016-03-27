require "rails_helper"

RSpec.feature "platform admin can approve a pending store" do
  scenario "can approve pending store" do
    user = User.create(username: "bacon", password: "password")
    other_user = User.create(username: "pancake", password: "password")
    3.times{create(:role)}
    user.roles << Role.find_by(name: "registered_user")
    user.roles << Role.find_by(name: "store_admin")
    user.roles << Role.find_by(name: "platform_admin")
    other_user.roles << Role.find_by(name: "registered_user")
    other_user.roles << Role.find_by(name: "store_admin")
    store = other_user.stores.create(name: "Farmer's Market")

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

  scenario "can suspend approved store" do
    user = User.create(username: "bacon", password: "password")
    other_user = User.create(username: "pancake", password: "password")
    3.times{create(:role)}
    user.roles << Role.find_by(name: "registered_user")
    user.roles << Role.find_by(name: "store_admin")
    user.roles << Role.find_by(name: "platform_admin")
    other_user.roles << Role.find_by(name: "registered_user")
    other_user.roles << Role.find_by(name: "store_admin")
    store = other_user.stores.create(name: "Farmer's Market", status: 2)

    visit "/login"
    fill_in "Username", with: "bacon"
    fill_in "Password", with: "password"
    click_on "Login to your account"

    visit "/dashboard"
    click_on "Platform Admin Information"

    expect(page).to have_content "Farmer's Market"
    expect(page).to have_content "Approved"
    click_on "Suspend"
    expect(page).to have_content "Suspended"
    
    visit "/farmer-s-market"
    expect(current_path).to_not eq("/farmer-s-market")
  end
end
