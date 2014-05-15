module DisplayBoard
  def display
    puts "   0  1  2  3  4  5  6  7"
    8.times do |row|
      line = []
      
      rows = (0..7).map do |col|
        square = self[[row, col]]
        
        if square.empty?
          square.color == :black ? "_*_" : "|_|"
        else
          square.piece.green? ? "_G_" : "_O_"
        end
        
      end
      print row, " "
      puts rows.join("")
    end
  end
end