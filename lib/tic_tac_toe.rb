class TicTacToe
  @board = []
  WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  ]
  def initialize
    @board = Array.new(9, " ")
  end
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(i)
    userinput = i.strip
    input = userinput.to_i - 1
  end

  def move(index, player)
    @board[index] = player
  end

  def position_taken?(index)
    !(@board[index].nil? ||@board[index] == " ")
  end

  def valid_move?(move)
    if move.between?(0,8)
      if position_taken?(move) == false
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def turn_count()
    i = 0 
    turncount = 0 
    while i < @board.length
      if @board[i] != " "
        turncount += 1 
      end
      i += 1
    end
    return turncount
  end

  def current_player()
    xcount = 0 
    ocount = 0 
    currentplayer = "X"
    if turn_count(@board) < 10
      @board.each do |n|
        if n == "X"
          xcount += 1 
        elsif n == "O"
          ocount += 1 
        end
      end
      if xcount > ocount
        currentplayer = "O"
      end 
    end
    return currentplayer
  end
  
end
