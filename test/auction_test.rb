require 'minitest/autorun'
require 'minitest/pride'
require './lib/auction'
require './lib/attendee'
require './lib/item'

class AuctionTest < Minitest::Test
  def setup
    @auction = Auction.new
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @item3 = Item.new('Homemade Chocolate Chip Cookies')
    @item4 = Item.new('2 Days Dogsitting')
    @item5 = Item.new('Forever Stamps')
    @attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    @attendee2 = Attendee.new(name: 'Bob', budget: '$75')
    @attendee3 = Attendee.new(name: 'Mike', budget: '$100')

    @auction2 = Auction.new
    @auction2.add_item(@item1)
    @auction2.add_item(@item2)
    @auction2.add_item(@item3)
    @auction2.add_item(@item4)
    @auction2.add_item(@item5)
  end

  def test_it_exists
    assert_instance_of Auction, @auction
  end

  def test_it_has_attributes
    assert_equal [], @auction.items
  end

  def test_add_items
    @auction.add_item(@item1)
    @auction.add_item(@item2)

    assert_equal [@item1, @item2], @auction.items
  end

  def test_item_names
    @auction.add_item(@item1)
    @auction.add_item(@item2)

    assert_equal ['Chalkware Piggy Bank', 'Bamboo Picture Frame'], @auction.item_names
  end

  def test_unpopular_items
    @item1.add_bid(@attendee2, 20)
    @item1.add_bid(@attendee1, 22)
    @item4.add_bid(@attendee3, 50)

    assert_equal [@item2, @item3, @item5], @auction2.unpopular_items

    @item3.add_bid(@attendee2, 15)

    assert_equal [@item2, @item5], @auction2.unpopular_items
  end

  def test_potential_revenue
    @item1.add_bid(@attendee2, 20)
    @item1.add_bid(@attendee1, 22)
    @item4.add_bid(@attendee3, 50)
    @item3.add_bid(@attendee2, 15)

    assert_equal 87, @auction2.potential_revenue
  end

  def test_bidders
    @item1.add_bid(@attendee2, 20)
    @item1.add_bid(@attendee1, 22)
    @item4.add_bid(@attendee3, 50)
    @item3.add_bid(@attendee2, 15)

    assert_equal ["Bob", "Megan", "Mike"], @auction2.bidders
  end

  def test_bidder_info
    @item1.add_bid(@attendee2, 20)
    @item1.add_bid(@attendee1, 22)
    @item4.add_bid(@attendee3, 50)
    @item3.add_bid(@attendee2, 15)

    @auction2.bidder_info
  end

  def test_current_bids
    @item1.add_bid(@attendee2, 20)
    @item1.add_bid(@attendee1, 22)
    @item4.add_bid(@attendee3, 50)
    @item3.add_bid(@attendee2, 15)

    assert_equal [@item1, @item3, @item4], @auction2.current_bids
  end
end
