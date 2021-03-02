class Item
  attr_reader :name,
              :bids

  def initialize(name)
    @name = name
    @bids = {}
    @bidders = []
  end

  def add_bid(attendee, bid)
    bids[attendee.name] = bid
  end

  def current_high_bid
    @bids.values.max
  end
end
