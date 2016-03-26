require "rails_helper"

RSpec.feature "store admin can create item" do
  scenario "can create item" do
    user = User.create(username: "bacon", password: "password")
    3.times{create(:role)}
    user.roles << Role.find_by(name: "registered_user")
    user.roles << Role.find_by(name: "store_admin")
    store = user.stores.create(name: "Farmer's Market")
    store.status = 2
    Category.create(title: "food")

    visit "/login"
    fill_in "Username", with: "bacon"
    fill_in "Password", with: "password"
    click_on "Login to your account"

    click_on "Store Admin Information"
    click_on "Create item"
    fill_in "Title", with: "Carrots"
    fill_in "Description", with: "Yum yum!"
    fill_in "Price", with: 1000
    check "food"
    click_on "Create Item"

    expect(page).to have_content "Carrots"
    expect(page).to have_content "$10.00"
  end
end


# As a logged in store admin
# I visit "/dashboard"
# And I Click on "create item"
# And I fill in item name with "Carrots"
# And I fill in item picture with "sample.png"
# And I fill in description with "They're REALLY orange"
# And I fill in price with "0.99"
# and I click on "Submit"
# Then I see the item in my store admin dashboard
# And I click on Edit next to the carrot
# and I change the price to "1.99"
# And I click on "Submit"
# Then I see the item with updated price in my admin dashboard
# And I click on delete next to carrots
# Then I do not see carrots on my dashboard anymore.
