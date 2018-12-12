class Card
  attr_reader :rank

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    return 10 if rank > 10

    rank
  end

  def show
    card_names = { 1 => 'A', 11 => 'J', 12 => 'Q', 13 => 'K' }
    suit_names = { clubs: '♣', diamonds: '♦', hearts: '♥', spades: '♠' }
    name = card_names[@rank] || @rank
    suit = suit_names[@suit]
    "#{name}#{suit}"
  end
end
