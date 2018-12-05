class Player
  attr_reader :name, :bank, :cards

  def initialize(name, bank)
    @name = name
    @bank = bank
    @cards = []
  end

  def take_card(card)
    @cards << card
  end

  def score
    # если есть туз и счёт менее или равен 11, то счёт += 10
    raw = score_raw
    raw += 10 if ace? && raw <= 11
    raw
  end

  def show_cards
    @cards.reduce('') { |acc, card| acc + "#{card.show} " }.lstrip
  end

  private

  def score_raw
    @cards.reduce(0) { |acc, card| acc + card.value }
  end

  def ace?
    !!@cards.detect { |card| card.number == 1 }
  end
end
