class TicTacToe
  @board = []
  @winningcombo = -1
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
  PLAYERS = ["X", "O"]
  def initialize
    @board = Array.new(9, " ")
  end

  def new
    self
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
    if turn_count() < 10
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

  def turn()
   valid = false
   while valid == false
    puts "Please enter 1-9:"
    mymove = input_to_index(gets.strip)
    if valid_move?(mymove)
      if position_taken?(mymove) == false
        move(mymove, current_player)
        valid = true
      end
    end
   end
   display_board
  end

  def won?
    result = winner
    if result == nil
      return false
    end
    return WIN_COMBINATIONS[@winningcombo]
  end

  def winner()
    winnerfound = false
    PLAYERS.each do |i|
      if iswinner(i) == i
        return i
        winnerfound = true
        break
      end
    end
    if winnerfound == false
      return nil
    end
  end

  def iswinner(player)
    winfound = false
    complete = false
    combo = []
    combinationcounter = 0

    until complete == true
      while combinationcounter < WIN_COMBINATIONS.length
        combo = WIN_COMBINATIONS[combinationcounter]
        combocounter = 0
        playercounter = 0
        while combocounter < combo.length
         boardcontent = @board[combo[combocounter]]
          if boardcontent == player
            playercounter += 1
          end
          combocounter += 1
        end
        if playercounter == 3
          winfound = true
          complete = true
          @winningcombo = combinationcounter
          break
        end
        combinationcounter += 1
      end
      complete = true
    end
    if winfound == true
      return player
    end
  end

  def full?()
    isfull = true
    @board.each do |location|
      if location == " "
        isfull = false
        break
      end
    end
    return isfull
  end

  def draw?
    result = won?
    isarray = result.class == Array
    fullboard = full?
    if result == false && fullboard == true
      #board is full and no winner
      return true
    elsif result
      #there was a winner, therefore no draw
      return false
    elsif result == false && fullboard == false
      #game is still in progress
      return false
    else
        #any other result would suggest a draw
        return true
    end
  end

  def over?
    return draw? == true || won? != false || full? == true
  end

  def play
    isover = over?
    if isover == false
      puts "Welcome to Tic Tac Toe!"
      display_board
      while isover == false
        puts "It's player #{current_player}'s turn"
        turn
        result = won?
        isover = over?
      end
    end

    if isover
      result = won?
      if result
        puts "Congratulations #{winner}!"
      end
      if draw? == true
        puts "Cat's Game!"
      end
    end
  end
end
