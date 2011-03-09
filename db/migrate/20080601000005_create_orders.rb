#---
# Excerpted from "Agile Web Development with Rails, 3rd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails3 for more book information.
#---
class CreateOrders < ActiveRecord::Migration
  #START:up
  def self.up
    create_table :orders do |t|
      t.string :name
      t.text :address
      t.string :email
#START_HIGHLIGHT
      t.string :pay_type, :limit => 10
#END_HIGHLIGHT

      t.timestamps
    end
  end
  #END:up

  def self.down
    drop_table :orders
  end
end