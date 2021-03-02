require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/item'

class ItemTest < Minitest::Test
  def setup
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
  end

  def test_it_exists
    assert_instance_of Item, @item1
    assert_instance_of Item, @item2
  end

  def test_it_has_attributes
    assert_equal 'Chalkware Piggy Bank', @item1.name
    assert_equal 'Bamboo Picture Frame', @item2.name
    assert_equal ({}), @item1.bids
    assert_equal ({}), @item2.bids
  end

  def test_add_bidd
    attendee2 = mock
    attendee2.stubs(:name).returns('Jeff')

    @item1.add_bid(attendee2, 20)

    assert_equal ({'Jeff' => 20}), @item1.bids
  end

  def test_current_high_bid
    attendee = mock
    attendee2 = mock
    attendee.stubs(:name).returns('Jenny')
    attendee2.stubs(:name).returns('Jeff')

    @item1.add_bid(attendee2, 20)
    assert_equal 20, @item1.current_high_bid

    @item1.add_bid(attendee, 32)
    assert_equal 32, @item1.current_high_bid
  end
end
