class Player
	def turn
		print "Move? - "
		input = gets.strip
		return input
	end
end

=begin
	class Bot
		def turn
		end
	end
=end

class Game
	@@players = {
		'player1' => Player.new,
		'player2' => Player.new
	}

	def initialize
		@board = [
			[" ", " ", " "],
			[" ", " ", " "],
			[" ", " ", " "]
		]
		@turn = 0
	end


	def start
		player_no = 1
		begin
			update(player_no)
			@turn += 1
			draw
			player_no =  player_no == 2? 1 : 2
			result = outcome
		end until(result == "done")
	end


	def update(player_no)
		begin
			input = @@players["player#{player_no}"].turn  
		end until (input_check(input) == true)

		row, column = input.split(" ").collect {|param| param.to_i - 1}
		@board[row][column] = "X"  if player_no == 1
		@board[row][column] = "O"  if player_no == 2
	end


	def input_check(input)
		row, column = input.split(" ").collect(&:to_i)
		unless ((1..3).include?(row) && (1..3).include?(column))
			puts "\nInvalid Input"
			puts
			return false
		end

		if (@board[row-1][column-1] == " ")
			return true
		else
			puts "\nSquare already taken"
			puts
			return false
		end
	end


	def outcome
		if (@turn == 9)
			puts "Draw"
			return "done"
		end

		winner = nil
		result = nil
		@board.each do |row|
			if (row[0] != " " && row[0] == row[1] && row[1] == row[2])
				result = "done"
				winner = row[0]
				break
			end
		end

		(0...3).each do |i|
			if (@board[0][i] != " " && @board[0][i] == @board[1][i] && @board[2][i] == @board[1][i])
				result = "done"
				winner = @board[0][i]
				break
			end
		end

		if (@board[1][1] != " " && @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2])
			result = "done"
			winner = @board[1][1]
		end

		if (@board[1][1] != " " && @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0])
			result = "done"
			winner = @board[1][1]
		end

		puts "#{winner} Wins!"  if (result)
		return result
	end


	def draw
		puts `clear`
		@board.each do |row|
			print " "
			puts row * " | "
			puts
		end
	end
end

game = Game.new
game.start
