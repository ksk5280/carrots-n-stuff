require 'rails_helper'

RSpec.describe "Registered User Permissions" do
  before(:each) do
    create_roles
    @user = store_manager
  end

  scenario "homes#show" do
    permission = Permission.new(@user, 'homes', 'show')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "items#index" do
    permission = Permission.new(@user, 'items', 'index')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "categories#index" do
    permission = Permission.new(@user, 'categories', 'index')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "categories#show" do
    permission = Permission.new(@user, 'categories', 'show')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "users#show" do
    permission = Permission.new(@user, 'users', 'show')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "sessions#new" do
    permission = Permission.new(@user, 'sessions', 'new')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "sessions#create" do
    permission = Permission.new(@user, 'sessions', 'create')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "sessions#destroy" do
    permission = Permission.new(@user, 'sessions', 'destroy')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "stores#index" do
    permission = Permission.new(@user, 'stores', 'index')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "stores#show" do
    permission = Permission.new(@user, 'stores', 'show')
    result = permission.allow?
    expect(result).to be true
  end
  scenario "cart_items#index" do
    permission = Permission.new(@user, 'cart_items', 'index')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "cart_items#create" do
    permission = Permission.new(@user, 'cart_items', 'create')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "cart_items#destroy" do
    permission = Permission.new(@user, 'cart_items', 'destroy')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "orders#index" do
    permission = Permission.new(@user, 'orders', 'index')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "orders#create" do
    permission = Permission.new(@user, 'orders', 'create')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "orders#show" do
    permission = Permission.new(@user, 'orders', 'show')
    result = permission.allow?
    expect(result).to be true
  end

  scenario "orders#update" do
    permission = Permission.new(@user, 'orders', 'update')
    result = permission.allow?
    expect(result).to be true
  end
end
