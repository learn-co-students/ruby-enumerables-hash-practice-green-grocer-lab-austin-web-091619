def consolidate_cart(cart)
  hash = {}
  cart.each do |item_hash|
    item_hash.each do |name, price_hash|
      if hash[name].nil?
        hash[name] = price_hash.merge({:count => 1})
      else
        hash[name][:count] += 1
      end
    end

  end
  hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    coupon.each do |key, value|
    name = coupon[:item]

    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:price => coupon[:cost],
          :clearance => cart[name][:clearance] :count => 1}
        end
    cart[name][:count] -= coupon[:num]
    end
  end
end


def apply_clearance(cart)
  cart.each do |key, value|
    if cart[value][:clearance] == true
      cart[value][:price] = (cart[value][:price] * .8).round(2)
    end
  end
  cart
end


def checkout(cart, coupons)
  total = 0
  new_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(new_cart, coupons)
  clearance_cart = apply_clearance(new_cart)

  clearance_cart.each do |key, value|
    total = total + (value[:price] * value[:count])
  end
  total = (total * .9) if total > 100 
  total
  end
