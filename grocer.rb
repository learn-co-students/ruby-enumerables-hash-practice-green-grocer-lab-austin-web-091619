require 'pry'

def consolidate_cart(cart)
 
  cart_hash = {}
  cart.map do |item_hash|
    #cart passes in a hash
    
    #item is the item name, keys returns an array and we want just the first value
    item = item_hash.keys[0]
    
    #if items in the cart, increment, otherwise put it in the cart
    if cart_hash.has_key?(item)
      cart_hash[item][:count] +=1
    else
      cart_hash[item]= item_hash[item]
      cart_hash[item][:count] = 1
    end
    
  end
  
  cart_hash
end

def apply_coupons(cart, coupons)
  # code here
  coupons.map do |coupon|
    #coupon is a hash with three keys: item,num, and cost
    
    #if the coupon item is in the cart add a new item to the cart
    #item W/ COUPON that starts the same as the cart item, but has a different price and count
    item = coupon[:item]
    coupon_item = "#{coupon[:item]} W/COUPON"
    if cart[item] && cart[item][:count] >= coupon[:num]
      #turn cost into a price per item
      pricer = coupon[:cost] / coupon[:num]
        if cart[coupon_item]
          cart[coupon_item] = {price: pricer, clearance: cart[item][:clearance], count: cart[coupon_item][:count] + coupon[:num]}
        else
          cart[coupon_item] = {price: pricer, clearance: cart[item][:clearance], count: coupon[:num]}
        end
      #cart[coupon_item][:price] = pricer
      #cart[coupon_item][:count] = coupon[:num]
      
      #original item count less the coupon num
      cart[item][:count] -= coupon[:num]
    end
  end
  
  cart
end

def apply_clearance(cart)
  
  cart.each do |item_hash|
    #binding.pry
    item = item_hash[0]
    if item_hash[1][:clearance]
      new_price = (cart[item][:price] * 0.8).round(2)
      cart[item][:price] = new_price
    end
    
  end
end

def checkout(cart, coupons)
  # code here
  ccart = consolidate_cart(cart)
  coupon_cart = apply_coupons(ccart, coupons)
  clear_cart = apply_clearance(coupon_cart)
  total_cost = 0
  clear_cart.each_key do |item_name|
    total_cost += clear_cart[item_name][:price]*clear_cart[item_name][:count]
  end
  if total_cost > 100
    total_cost *= 0.9
  end
  total_cost
end
