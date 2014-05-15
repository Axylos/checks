class Game

  def initialize(player1, player2, board)
    @player1 = player1
    @player1.color = :orange
    @player2 = player2
    @player2.color = :green
    @board = board
  end
  
  def winner?
    pieces = @board.pieces_on_board
    
    if pieces.all? { |piece| piece.color == :green}
      return @player1
    elsif pieces.all? { |piece| piece.color == :orange }
      return @player2
    else
      return nil
    end
  end
  
  def run
   @current_player = @player1
   
   until winner?
     @board.display
     puts "It is #{@current_player.color}'s turn!"
     move = @current_player.get_move
     
     begin
       make_move move
     rescue InvalidMoveError
       puts "Invalid Move!"
       retry
     end

     toggle_player
   end

   puts "#{winner?} Won!"
    
  end
  
  def toggle_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
  
  def make_move(moves)
    
    start_pos = moves.shift
    piece = @board[start_pos].piece
    raise "Not your piece!" if piece.color != @current_player.color
    
    if moves.count > 1
      piece.perform_moves(moves)
    else
      @board.move(start_pos, moves.last)
    end
  end

end