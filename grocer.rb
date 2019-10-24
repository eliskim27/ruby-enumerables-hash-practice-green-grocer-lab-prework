def consolidate_cart(cart)
  new_hash = {}
  cart.each_with_index do |thing,index|
    if new_hash[thing.keys[0]]  
      new_hash[thing.keys[0]][:count] += 1
    else
      new_hash[thing.keys[0]] = {
        price: thing.values[0][:price],
        clearance: thing.values[0][:clearance],
        count: 1
      }
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]   
      if coupon[:num] <= cart[coupon[:item]][:count]
        new_item = "#{coupon[:item]} W/COUPON"
        if cart[new_item] #exists
          cart[new_item][:count] += coupon[:num]
        else
          cart[new_item] = {
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
      new_price = cart[item][:price]*0.8
      cart[item][:price] = new_price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidate_cart
  apply_coupons
  apply_clearance
end















