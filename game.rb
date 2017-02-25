class User
	def turn
		print "Move? - "
		input = gets.strip
		return input
	end

	def input_check(input)

	end
end

class Bot
	def turn
		print "Move? - "
		input = gets.strip
		return input
	end

	# ...
end

class Game
	@@players = {
		'player1' => User.new,
		'player2' => Bot.new
	}

	def initialize
		@board = [
			[" ", " ", " "],
			[" ", " ", " "],
			[" ", " ", " "]
		]
	end

	def start
		player_no = 1
		begin
			update(player_no)
			draw
			# result = outcome
			result = false
			player_no =  player_no == 2? 1 : 2
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
		# ...
		# return result
	end

	def draw
		puts `clear`
		@board.each do |row|
			puts row * " | "
			puts
		end
	end
end

game = Game.new
game.start
