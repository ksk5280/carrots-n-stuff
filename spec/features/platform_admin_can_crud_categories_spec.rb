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
    expect(page).to have_content "Category created succesfully."
    expect(page).to have_content "That New New"
  end

  scenario "category create, user sees error message " do
    create_roles
    user = platform_admin

    create_categories

    login(user)

    expect(current_path).to eq "/dashboard"
    click_on "Platform Admin Information"

    expect(page).to have_content "#{Category.first.title}"
    click_on "Create New Category"
    expect(current_path).to eq new_category_path
    fill_in "Title", with: ""
    click_on "Create Category"

    expect(current_path).to eq "/categories"
    expect(page).to have_content "Title can't be blank"
  end

  scenario "can see dashboard with updated category" do
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
    expect(page).to have_content "Category updated successfully."
    expect(page).to have_content "New Category"
    expect(page).not_to have_content "That New New"
  end

  scenario "update category, user sees error message" do
    create_roles
    user = platform_admin

    login(user)

    expect(current_path).to eq "/dashboard"
    click_on "Platform Admin Information"

    create_category
    expect(page).to have_content "That New New"

    click_on "Update Category"
    fill_in "Title", with: ""
    click_on "Update Category"
    expect(page).to have_content "Title can't be blank"
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
