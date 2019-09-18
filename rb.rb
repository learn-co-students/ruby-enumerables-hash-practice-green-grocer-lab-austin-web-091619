cart = [
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"KALE"    => {:price => 3.00, :clearance => false}},
  {"Bananas"    => {:price => 4.00, :clearance => false}},
  {"Mango"   => {:price => 5.00, :clearance => false}},
  {"Bananas"    => {:price => 4.00, :clearance => false}}
]

def consolidate_cart(cart)
  new_cart = {}
  cart.each do |item|
    if new_cart[item.keys[0]]
      new_cart[item.keys[0]][:count] += 1
    else
      new_cart[item.keys[0]] = {
        price: item.values[0][:price],
        clearance: item.values[0][:clearance],
        count: 1
      }
    end
  end
  new_cart
end



consolidate_cart(cart)


groceries = {
  AVOCADO: {price: 3.00, clearance: true, count: 3},
  KALE: {price: 3.00, clearance: false, count: 1}
}

p groceries

coupons = [{item: "AVOCADO", num: 2, cost: 5.00}]
