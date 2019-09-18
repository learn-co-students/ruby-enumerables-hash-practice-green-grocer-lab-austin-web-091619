def consolidate_cart(cart)
  hash = {}
  cart.each do |item|
    if hash[item.keys[0]]
      hash[item.keys[0]][:count] += 1
    else
      hash[item.keys[0]] = {
        price: item.values[0][:price],
        clearance: item.values[0][:clearance],
        count: 1
      }
    end
  end
  p hash
end

def apply_coupons(cart, coupons)
    coupons.each do |coupon|
        if cart.keys.include? coupon[:item]
            if cart[coupon[:item]][:count] >= coupon[:num]
                new_name = "#{coupon[:item]} W/COUPON"
                if cart[new_name]
                    cart[new_name][:count] += coupon[:num]
                else
                  cart[new_name] = {
             count: coupon[:num],
             price: coupon[:cost]/coupon[:num],
             clearance: cart[coupon[:item]][:clearance]
           }
                end
                cart[coupon[:item]][:count] -= coupon[:num]
            end
        end
    end
    cart
end





def apply_clearance(cart)
    cart.keys.each do |item|
        if cart[item][:clearance]
            cart[item][:price] = (cart[item][:price]*0.8).round(2)
        end
    end
    p cart
end

def checkout(complete, coupons)
    consolidated = consolidate_cart(complete)
    cart_w_coupons = apply_coupons(consolidated, coupons)
    cart_w_clearance = apply_clearance(cart_w_coupons)

    total = 0
    cart_w_clearance.keys.each do |item|
        total += cart_w_clearance[item][:price] * cart_w_clearance[item][:count]
    end
    total > 100.00? (total * 0.9). round : total
end
