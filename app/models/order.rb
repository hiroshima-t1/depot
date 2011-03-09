#---
# Excerpted from "Agile Web Development with Rails, 3rd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails3 for more book information.
#---
#START:has_many
#START:select
#START:validate
class Order < ActiveRecord::Base
  #END:has_many
  PAYMENT_TYPES = [
    #  Displayed       stored in db
    [ "Check",          "check" ],
    [ "Credit card",    "cc" ],
    [ "Purchase order", "po" ]
  ]

#END:validate
  # ...
  #END:select
  #START:validate
  validates_presence_of :name, :address, :email, :pay_type
  validates_inclusion_of :pay_type, :in => 
    PAYMENT_TYPES.map {|disp, value| value}

  # ...
  #END:validate


  #START:has_many
  has_many :line_items
  #END:has_many

  #START:add_line_items_from_cart
  def add_line_items_from_cart(cart)
    cart.items.each do |item|
      li = LineItem.from_cart_item(item)
      line_items << li
    end
  end
  #END:add_line_items_from_cart
#START:has_many
end
#END:has_many