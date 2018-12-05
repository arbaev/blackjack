class Deck
  SUITS = %i[clubs diamonds hearts spades].freeze
  attr_reader :deck

  def initialize
    @deck = make_deck.shuffle
  end

  def deal_card
    @deck.pop
  end

  private

  def make_deck
    (1..13).to_a.product(SUITS).map { |number, suit| Card.new(number, suit) }
  end
end
