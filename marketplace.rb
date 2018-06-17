require_relative('checkout')
require_relative('promotional_rules')

co = Checkout.new(PromotionalRules)

def convert_total_to_pounds(total)
  "£#{total.to_f / 100}"
end

def scan_item(checkout)
  puts "Please enter code of the item you want"
  item_code = gets.strip
  checkout.scan(item_code)
  puts "Do you want to add another item to the basket? enter y or n"
  answer = gets.strip
  if answer == 'y'
    scan_item(checkout)
  end
end

puts "-------------------------Marketplace--------------------------"

puts "The items available are:\n#{Checkout::ITEMS.map{|item| "#{item[:name]} | price #{item[:price]} | code #{item[:code]}"}.join("\n")}"

puts "--------------------------------------------------------------"

scan_item(co)

puts "Basket: #{co.basket.join(',')}"
puts "Total price: #{convert_total_to_pounds(co.total)}"
