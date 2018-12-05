require_relative 'player'
require_relative 'deck'
require_relative 'card'

pl1 = Player.new("pl", 100)
pl2 = Player.new("dealer", 100)

d = Deck.new

aa1 = Card.new(1, :spades)
aa2 = Card.new(12, :hearts)
aa3 = Card.new(9, :diamonds)
aa4 = Card.new(1, :clubs)

puts pl1.name
puts pl1.bank
puts pl1.take_card(d.deal_card)
puts pl1.take_card(d.deal_card)
puts '==============='
puts pl1.cards[0]
puts pl1.cards[0].show
puts pl1.cards[0].value
puts '==============='
puts pl1.show_cards
puts "score: #{pl1.score}"

# puts pl2.take_card(aa2)
puts pl2.take_card(aa3)
puts pl2.take_card(aa1)
puts pl2.show_cards
puts "score: #{pl2.score}"