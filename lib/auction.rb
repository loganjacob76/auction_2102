class Auction
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map do |item|
      item.name
    end
  end

  def unpopular_items
    @items.find_all do |item|
      item.bids == {}
    end
  end

  def potential_revenue
    current_bids.map do |item|
      item.current_high_bid
    end.sum
  end

  def bidders
    current_bids.flat_map do |item|
      item.bids.keys
    end.uniq
  end

  def bidder_info

  end

  def current_bids
    @items.find_all do |item|
      item.bids != {}
    end
  end
end
