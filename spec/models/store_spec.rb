require 'rails_helper'

RSpec.describe Store, type: :model do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should have_many :items }
  it { should have_many :users }

  it "creates slug" do
    store = Store.create(name: "Farmer's Market")
    expect(store.slug).to eq "farmer-s-market"
  end

  it "returns all active stores" do
    approved_store = Store.create(name: "Newly Approved",
                                  description: "We just got approved ya'll",
                                  status: 2)
    suspended_store = Store.create(name: "Suspended",
                                   description: "We were bad and now we're suspended..",
                                   status: 1)
    pending_store = Store.create(name: "Mod Market",
                                 description: "Modern times calls for modern Markets..",
                                 status: 0)

    expect(Store.all_active).to eq([approved_store])
  end
end
