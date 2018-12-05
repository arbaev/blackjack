class Card
  attr_reader :number

  def initialize(number, suit)
    @number = number
    @suit = suit
    # TODO: сделать валидацию
  end

  def value
    return 10 if @number > 10

    @number
  end

  def show
    card_names = { 1 => 'A', 11 => 'J', 12 => 'Q', 13 => 'K' }
    suit_names = { clubs: '♣', diamonds: '♦', hearts: '♥', spades: '♠' }
    name = card_names[@number] || @number
    suit = suit_names[@suit]
    "#{name}#{suit}"
  end
end
