#---
# Excerpted from "Agile Web Development with Rails, 3rd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails3 for more book information.
#---
require 'test_helper'
require 'store_controller'

class OrderSpeedTest < ActionController::TestCase
  tests StoreController
  
  DAVES_DETAILS = {
      :name     => "Dave Thomas",
      :address  => "123 The Street",
      :email    => "dave@pragprog.com",
      :pay_type => "check"
  }
  
  #START:fixtures
  self.fixture_path = File.join(File.dirname(__FILE__), "../fixtures/performance")
  fixtures :products
  #END:fixtures
  

  #START:test
  def test_100_orders
    Order.delete_all
    LineItem.delete_all

    #START:silence
    @controller.logger.silence do
    #END:silence
      elapsed_time = Benchmark.realtime do
        100.downto(1) do |prd_id|
          cart = Cart.new
          cart.add_product(Product.find(prd_id))
          post :save_order, 
               { :order => DAVES_DETAILS },
               { :cart  => cart }
          assert_redirected_to :action => :index
        end         
      end       
      assert_equal 100, Order.count
      assert elapsed_time < 3.00
    #START:silence  
    end
    #END:silence
  end
  #END:test
end