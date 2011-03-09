#---
# Excerpted from "Agile Web Development with Rails, 3rd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails3 for more book information.
#---
#START:initial
require 'test_helper'

class CartTest < ActiveSupport::TestCase
  #START:fixtures
  fixtures :products
  #END:fixtures
  #END:initial
  #START:unique_products
  def test_add_unique_products
    cart = Cart.new
    rails_book = products(:rails_book)
    ruby_book  = products(:ruby_book)
    cart.add_product rails_book
    cart.add_product ruby_book
    assert_equal 2, cart.items.size
    assert_equal rails_book.price + ruby_book.price, cart.total_price
  end
  #END:unique_products
  
  #START:duplicate_product
  def test_add_duplicate_product
    cart = Cart.new
    rails_book = products(:rails_book)
    cart.add_product rails_book
    cart.add_product rails_book
    assert_equal 2*rails_book.price, cart.total_price
    assert_equal 1, cart.items.size
    assert_equal 2, cart.items[0].quantity
  end 
  #END:duplicate_product
#START:initial
end
#END:initial