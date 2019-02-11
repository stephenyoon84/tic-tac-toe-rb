WIN_COMBINATIONS = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8],
  [0, 3, 6], [1, 4, 7], [2, 5, 8],
  [0, 4, 8], [2, 4, 6]
]
def display_board(arr)
  puts " #{arr[0]} | #{arr[1]} | #{arr[2]} \n-----------\n #{arr[3]} | #{arr[4]} | #{arr[5]} \n-----------\n #{arr[6]} | #{arr[7]} | #{arr[8]} "
end

def input_to_index(input)
  return input.to_i - 1
end

def move(board, input, player)
  board[input] = player
  return board
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if (!position_taken?(board, index) && index.between?(0, 8))
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |x|
    if x != " " && x != ""
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  player = turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  is_won = false
  for win_combination in WIN_COMBINATIONS
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if position_1 == position_2 && position_2 == position_3 && position_taken?(board, win_index_1)
      return win_combination
    else
      false
    end
  end
  is_won
end

def full?(board)
  is_full = true
  for i in 0..8
    if !position_taken?(board, i)
      is_full = false
    end
  end
  return is_full
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    false
  end
end

def over?(board)
  if draw?(board)
    return true
  elsif won?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    return nil
  end
end

def play(board)
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  else
    until over?(board)
      turn(board)
      if won?(board)
        puts "Congratulations #{winner(board)}!"
      elsif draw?(board)
        puts "Cat's Game!"
      end
    end
  end
end
