class Market
  attr_reader :name, :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.include?(item)
    end
  end

  def total_inventory
    total = {}
    items = @vendors.flat_map {|vendor| vendor.inventory.keys}.uniq
    items.each do |item|
      vendors_for_item = vendors_that_sell(item)
      total_amount = vendors_for_item.sum {|vendor| vendor.inventory[item]}
      total[item] = {quantity: total_amount, vendors: vendors_for_item}
    end
    total
  end

end
