#!/usr/bin/env ruby
require "debugger"
require "pry"
require "./display.rb"
require "./make_board.rb"
require "./board.rb"
require "./tile.rb"
require "./piece.rb"

b = Board.new

b.move [5, 2], [4, 3]
b.move [2, 3], [3, 4]
b.move [5, 0], [4, 1]
b.move [4, 3], [3, 2]
b.move [6, 1], [5, 2]
p = b[[2, 1]].piece



b.display
pry





