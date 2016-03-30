require 'rails_helper'

RSpec.feature "store admin can hire and fire new store managers" do
  scenario "store admin sees new store manager on dashboard then fires them" do
    create_roles
    user = store_admin
    store = approved_store(user)
    reg_user = registered_user

    login(reg_user)

    visit "/#{store.slug}"

    click_on "Apply for Manager position"
    expect(page).to have_content "Your application has been submitted."

    visit "/#{store.slug}"
    expect(page).not_to have_button "Apply for Manager position"

    click_on "Logout"

    login(user)

    click_on "Store Admin Information"

    expect(page).to have_content "#{reg_user.first_name} #{reg_user.last_name}: Pending"

    click_on "Hire applicant"

    expect(page).to have_content "#{reg_user.first_name} #{reg_user.last_name} is now a #{store.name} team member."
    expect(page).to have_content "#{reg_user.first_name} #{reg_user.last_name}: Hired"
    click_on "Fire employee"
    expect(page).to have_content "#{reg_user.first_name} #{reg_user.last_name} has been fired"
    within ".employees" do
      expect(page).not_to have_content "#{reg_user.first_name} #{reg_user.last_name}"
    end
  end
end
