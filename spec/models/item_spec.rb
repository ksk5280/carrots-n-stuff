require "rails_helper"

RSpec.describe Item, type: :model do
  it { should validate_presence_of :title }
  it { should validate_uniqueness_of(:title).case_insensitive }
  it { should validate_presence_of :description }
  it { should validate_presence_of :price }
  it { should validate_numericality_of(:price).is_greater_than(0) }
  it { should validate_presence_of :categories }
  it { should have_many(:category_items) }
  it { should have_many(:categories).through(:category_items) }
  it { should have_many :line_items }
  it { should have_many(:orders).through(:line_items) }

  it "finds items for all active stores" do
    create_categories
    approved_store = Store.create(name: "Newly Approved",
                                  description: "We just got approved ya'll",
                                  status: 2)
    suspended_store = Store.create(name: "Suspended",
                                   description: "We were bad and now we're suspended..",
                                   status: 1)
    pending_store = Store.create(name: "Mod Market",
                                 description: "Modern times calls for modern Markets..",
                                 status: 0)
    item1 = item(approved_store)
    item2 = item2(suspended_store)
    item3 = item3(pending_store)
    expect(Item.all_for_active_stores).to eq [item1]
  end
end
