require 'rspec'
require './lib/item'
require './lib/vendor'
require './lib/market'
require 'date'

describe "#exists" do
  it "exists" do
    market = Market.new("South Pearl Street Farmers Market") 

    expect(market).to be_an_instance_of(Market)
  end

  it "has readable attributes" do
    market = Market.new("South Pearl Street Farmers Market") 

    expect(market.name).to eq("South Pearl Street Farmers Market")
    expect(market.vendors).to eq([])
  end
end

describe "#vendor_features" do
  before(:each) do
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: "$0.50"})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7) 
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2) 
    @market.add_vendor(@vendor3)
  end

    it "can add vendors" do 
      expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    end

    it "can check vendor names" do
      expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end

    it "can find vendors that sell a specific item" do
      expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
    end
end

describe "#market features" do
  before(:each) do
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: "$0.50"})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7) 
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2) 
    @market.add_vendor(@vendor3)
  end
    
    it "can sort items in stock alpabetically" do 
      expect(@market.sorted_item_list).to eq(["Banana Nice Cream", 'Peach', "Peach-Raspberry Nice Cream", 'Tomato'])
    end

    it "can report total quanities of items being sold at the market" do
      expect(@market.total_inventory).to eq({
        @item1 => {quantity: 100, vendors: [@vendor1, @vendor3]},
        @item2 => {quantity: 7, vendors: [@vendor1]},
        @item3 => {quantity: 25, vendors: [@vendor2]},
        @item4 => {quantity: 50, vendors: [@vendor2]}
      })
    end

    it "can check if an item is overstocked" do
      expect(@market.overstocked_items).to eq([@item1])
    end
end

describe "#date" do
  it "returns the current date in the correct format" do
    @market = Market.new("South Pearl Street Farmers Market")
    expect(@market.date).to eq('17/04/2023')
  end
end

describe "#sell" do
  it "sells items from vendors when stock is low" do
    
  end
end
  
