class Market
  attr_reader :name, :vendors, :date
  def initialize(name)
    @name = name
    @vendors = []
    @date = Time.new.strftime("%m-%d-%Y").freeze
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

  def quantity(item)
  @vendors.sum do |vendor|
    vendor.inventory[item]
  end
end

  def total_inventory
    hash = {}
    list_of_names.each do |item|
      hash[item] = {quantity:quantity(item), vendors:vendors_that_sell(item)}
    end
    hash
  end

  def list_of_names
    item_list = []
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        item_list << item
      end
    end
    item_list.flatten.uniq
  end

  def sorted_item_list
    list_of_names.map do |item|
      item.name
    end.sort
  end

  def overstocked_items
    total_inventory.map do |item, data|
      item if data[:vendors].count > 1 && data[:quantity] > 50
    end.compact
  end
end
