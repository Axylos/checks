#!/usr/bin/env ruby

require "./display.rb"
require "./make_board.rb"
require "./board.rb"
require "./tile.rb"
require "./piece.rb"
require "./game.rb"
require './player.rb'



b = Board.new
b.move [5, 2], [4, 3]
b.move [4, 3], [3, 4]
b.move [6, 1], [5, 2]



p = Player.new
p2 = Player.new

g = Game.new(p, p2, b)
g.run





