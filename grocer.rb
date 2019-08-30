def consolidate_cart(cart)
hashed_cart = {} #create empty hash for cart

cart.each do |element_hash| # create a loop that for each element of the hash...
  element_name = element_hash.keys[0] #initiate the element name as the first key of the hash
  if hashed_cart.has_key?(element_name) #if the key being evaluated already exist...
    hashed_cart[element_name][:count] += 1 #increment the count by one, if it doesn't exist...
  else
    hashed_cart[element_name] = { #let's create the hash with the following structure. 
      price: element_hash[element_name][:price],
      clearance: element_hash[element_name][:clearance],
      count:1 
    }
    end
  end
  return hashed_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
  item = coupon[:item]
  coupon_item = "#{item} W/COUPON"
  if cart.has_key?(item) 
    if cart[item][:count] >= coupon[:num]
      if !cart[coupon_item]
        cart[coupon_item] = {count: coupon[:num], price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance] , count: coupon[:num]}
      else 
        cart[coupon_item][:count] += coupon[:num]
      end
      cart[item][:count] -= coupon[:num]
    end
  end
end
cart
end

def apply_clearance(cart)
cart.each do |product_name, stats|
  stats[:price] -= stats[:price] * 0.2 if stats[:clearance]
  end
  return cart
end

def checkout(array, coupons)
  hash_cart = consolidate_cart(array)
  applied_coupons = apply_coupons(hash_cart,coupons)
  applied_discount = apply_clearance(applied_coupons)
  
  total = applied_discount.reduce(0) { |acc, (key, value)| acc += value[:price] * value[:count]}
  total > 100 ? total * 0.9 : total 
end
