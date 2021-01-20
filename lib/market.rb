require 'date'

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

#iteration 4
#   def sell(item, quantity)
#     inventory = total_inventory
#     to_be_sold = quantity
#     if inventory[item][:quantity] < quantity
#       false #does not satisfy
#     else
#       # require "pry"; binding.pry
#       vendors = vendors_that_sell(item)
#       vendors.each do |vendor|
#         to_be_sold -= vendor.inventory[item]
#         vendor.inventory[item] -= quantity
#         break if to_be_sold == 0
#       end
#       true #to satisfy the given quantity
#     end
#   end
# end
#
# . If the Market's has enough of the item in stock to satisfy the given quantity, this method should return `true`.
# Additionally, this method should reduce the stock of the Vendors. It should look through the
# Vendors in the order they were added and sell the item from the first Vendor with that item in stock.
# If that Vendor does not have enough stock to satisfy the given quantity, the Vendor's entire stock of that item will be depleted,
# and the remaining quantity will be sold from the next vendor with that item in stock. It will follow this pattern until
# the entire quantity requested has been sold.
# #
# # For example, suppose vendor1 has 35 `peaches` and vendor3 has 65 `peaches`,
# and vendor1 was added to the market first. If the method `sell(<ItemXXX,
#   @name = 'Peach'...>, 40)` is called, the method should return `true`, vendor1's new stock of
#   `peaches` should be 0, and vendor3's new stock of `peaches` should be 60.
