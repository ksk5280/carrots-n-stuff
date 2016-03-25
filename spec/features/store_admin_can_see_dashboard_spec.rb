require "rails_helper"

RSpec.feature "Store admin can see store admin dashboard" do
  scenario "can see store admin dashboard" do
    user = User.create(username: "bacon", password: "password")
    3.times{create(:role)}
    user.roles << Role.find_by(name: "store_admin")

    visit "/login"
    fill_in "Username", with: "bacon"
    fill_in "Password", with: "password"
    click_on "Login to your account"

    expect(current_path).to eq("/dashboard")

    click_on "Store Admin Information"

    expect(page).to have_content eq("Order ID: 1")
    expect(page).to have_content eq("Bacon")
    expect(page).to have_content eq("$9.99")
  end
end
