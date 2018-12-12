class Deck
  SUITS = %i[clubs diamonds hearts spades].freeze
  RANKS = (1..13).to_a

  attr_reader :deck

  def initialize
    @deck = make_deck.shuffle
  end

  def deal_card
    @deck.pop
  end

  private

  def make_deck
    RANKS.product(SUITS).map { |rank, suit| Card.new(rank, suit) }
  end
end
