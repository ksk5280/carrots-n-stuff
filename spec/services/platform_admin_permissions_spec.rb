require 'rails_helper'

RSpec.describe "Registered User Permissions" do
  before(:each) do
    create_roles
    @user = platform_admin
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
end
