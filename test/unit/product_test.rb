#---
# Excerpted from "Agile Web Development with Rails, 3rd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails3 for more book information.
#---
#START:original
require 'test_helper'

class ProductTest < ActiveSupport::TestCase
#END:original
  
  #START:fixtures
  fixtures :products
  #END:fixtures
  
#START:original
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
#END:original

  #START:test_empty_attributes
  test "invalid with empty attributes" do
    product = Product.new
    assert !product.valid?
    assert product.errors.invalid?(:title)
    assert product.errors.invalid?(:description)
    assert product.errors.invalid?(:price)
    assert product.errors.invalid?(:image_url)
  end
  #END:test_empty_attributes

  #START:test_positive_price
  test "positive price" do
    product = Product.new(:title       => "My Book Title",
                          :description => "yyy",
                          :image_url   => "zzz.jpg")
    product.price = -1
    assert !product.valid?
    assert_equal "should be at least 0.01", product.errors.on(:price)

    product.price = 0
    assert !product.valid?
    assert_equal "should be at least 0.01", product.errors.on(:price)

    product.price = 1
    assert product.valid?
  end
  #END:test_positive_price

  #START:test_image_url
  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
             http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    
    ok.each do |name|
      product = Product.new(:title       => "My Book Title",
                            :description => "yyy",
                            :price       => 1,
                            :image_url   => name)
      assert product.valid?, product.errors.full_messages
    end

    bad.each do |name|
      product = Product.new(:title => "My Book Title",
                            :description => "yyy",
                            :price => 1,
                            :image_url => name)
      assert !product.valid?, "saving #{name}"
    end
  end
  #END:test_image_url

  #START:test_unique_title
  test "unique title" do
    product = Product.new(:title       => products(:ruby_book).title,
                          :description => "yyy", 
                          :price       => 1, 
                          :image_url   => "fred.gif")

    assert !product.save
    assert_equal "has already been taken", product.errors.on(:title)
  end
  #END:test_unique_title

  #START:test_unique_title1
  test "unique title1" do
    product = Product.new(:title       => products(:ruby_book).title,
                          :description => "yyy", 
                          :price       => 1, 
                          :image_url   => "fred.gif")

    assert !product.save
    assert_equal I18n.translate('activerecord.errors.messages.taken'),
                 product.errors.on(:title)
  end
  #END:test_unique_title1
  
#START:original
end
#END:original