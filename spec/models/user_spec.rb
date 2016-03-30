require "rails_helper"

RSpec.describe User, type: :model do
  it { should validate_presence_of :username }
  it { should validate_uniqueness_of :username }
  it { should validate_presence_of :password }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :address }
  it { should validate_presence_of :email }
  it { should have_secure_password }
  it { should have_many :orders }
  it { should belong_to :store }
end
