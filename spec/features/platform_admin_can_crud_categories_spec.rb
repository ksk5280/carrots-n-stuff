require "rails_helper"

RSpec.feature "platfom admin has category CRUD functionality" do
  scenario "can see dashboard with new category" do
    create_roles
    user = platform_admin

    create_categories

    login(user)

    expect(current_path).to eq "/dashboard"
    click_on "Platform Admin Information"

    expect(page).to have_content "#{Category.first.title}"
    click_on "Create New Category"
    expect(current_path).to eq new_category_path
    fill_in "Title", with: "That New New"
    click_on "Create Category"

    expect(current_path).to eq "/dashboard"
    expect(page).to have_content "That New New"
  end

  scenario "can see dashboard with new category" do
    create_roles
    user = platform_admin

    login(user)

    expect(current_path).to eq "/dashboard"
    click_on "Platform Admin Information"

    create_category
    expect(page).to have_content "That New New"

    click_on "Update Category"
    fill_in "Title", with: "Not So New"
    click_on "Update Category"

    expect(current_path).to eq "/dashboard"
    expect(page).to have_content "New Category"
    expect(page).not_to have_content "That New New"
  end

  scenario "can see dashboard with without deleted category" do
    create_roles
    user = platform_admin

    login(user)

    expect(current_path).to eq "/dashboard"
    click_on "Platform Admin Information"

    create_category
    expect(current_path).to eq "/dashboard"

    expect(page).to have_content "That New New"
    click_on "Delete Category"
    expect(current_path).to eq "/dashboard"
    expect(page).not_to have_content "That New New"
  end
end
