require 'rspec'
require './lib/item'
require './lib/vendor'

describe "#exists" do
  it "exists" do
    vendor = Vendor.new("Rocky Mountain Fresh")

    expect(vendor).to be_an_instance_of(Vendor)
  end

  it "has readable attributes" do
    vendor = Vendor.new("Rocky Mountain Fresh")

    expect(vendor.name).to eq("Rocky Mountain Fresh")
    expect(vendor.inventory).to eq({})
  end
end

describe "#check_stock" do
  it "has a default value of 0" do
    vendor = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})

    expect(vendor.check_stock(item1)).to eq(0)
  end

  it "can place items in inventory" do
    vendor = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})

    vendor.stock(item1, 30)
    expect(vendor.inventory).to eq({item1 => 30})
  end

  it "can check the quantity of items in stock" do
    vendor = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})

    vendor.stock(item1, 30)
    expect(vendor.check_stock(item1)).to eq(30)
  end

  it "can add more of an item thats already in stock" do 
    vendor = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})

    vendor.stock(item1, 30)
    vendor.stock(item1, 25)
    expect(vendor.check_stock(item1)).to eq(55)
  end

  it "can stock multiple items" do
    vendor = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})

    vendor.stock(item1, 30)
    vendor.stock(item1, 25)
    vendor.stock(item2, 12)

    expect(vendor.check_stock(item1)).to eq(55)
    expect(vendor.check_stock(item2)).to eq(12)
    expect(vendor.inventory).to eq({item1 => 55, item2 => 12})

  end
end