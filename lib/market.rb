class Market

  attr_reader :name, :vendors, :date

  def initialize(name)
    @name = name
    @vendors = []
    @date = Date.today.strftime("%d/%m/%Y")
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    vendor_names = @vendors.map do |vendor|
      vendor.name
    end
    vendor_names
  end

  def vendors_that_sell(item)
    vendors.select { |vendor| vendor.inventory.keys.include?(item) }
  end

  def sorted_item_list
    vendors.flat_map { |vendor| vendor.inventory.keys.map(&:name) }.uniq.sort
  end

  def total_inventory
  inventory = Hash.new { |hash, key| hash[key] = { quantity: 0, vendors: [] } }

    vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        inventory[item][:quantity] += quantity
        inventory[item][:vendors] << vendor unless inventory[item][:vendors].include?(vendor)
      end
    end
    inventory
  end

  def overstocked_items
    overstocked_items = []
    vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        if quantity > 50 && vendors_that_sell(item).size > 1
          overstocked_items << item
        end
      end
    end
    overstocked_items
  end

  def sell
    
  end

end

#sorted_item_list = An array of the names of all items the Vendors have in stock, sorted alphabetically. 
#This list should not include any duplicate items.

#total_inventory = Reports the quantities of all items sold at the market. Specifically, it should return 
#a hash with items as keys and hashes as values - this sub-hash should have two key/value pairs: quantity
#pointing to total inventory for that item and vendors pointing to an array of the vendors that sell that item.

#overstocked_items =  An array of `Item` objects that are overstocked. An item is overstocked if it is sold 
#by more than 1 vendor AND the total quantity is greater than 50.