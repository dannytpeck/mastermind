def generate_one_color
	result = rand(6)
	color = "R" if result == 0
	color = "O" if result == 1
	color = "Y" if result == 2
	color = "G" if result == 3
	color = "B" if result == 4
	color = "P" if result == 5
	color
end

def generate_code
	code = []
	4.times do 
		code << generate_one_color
	end
	code
end

def valid_code?(code)
	if code.downcase.scan(/[roygbp]/).count == 4
		true
	else
		false
	end
end

def check_guess(guess, code)
	response = []
	(0..3).each do |number|
		if guess[number].upcase == code[number]
			response << "b"
		elsif code.include?(guess[number].upcase)
			response << "w"
		end
	end
	response.join
end

def hit_enter_to_continue
	while true
		input = gets.chomp
		break
	end
end

def play_as_code_breaker
	secret_code = generate_code
	turns_remaining = 12
	while true
		puts "Colored pegs are: (R)ed, (O)range, (Y)ellow, (G)reen, (B)lue, (P)urple.\n" + 
		      "Response pegs are colored (b)lack for a successful guess and (w)hite.\n" +
		      "when the color is somewhere in the code but in the wrong place.\n\n" +
		      "What is your guess?"
		guess = gets.chomp

		if valid_code?(guess) == false
			puts "Guess must be four letters from the color list."
		else
			guessed_colors = guess.split(//)
			turns_remaining -= 1

			if check_guess(guessed_colors, secret_code) == "bbbb"
				puts "Good job! You've cracked the secret code!"
				break
			end

			puts "Results: " + check_guess(guessed_colors, secret_code)

			if turns_remaining == 0
				puts "You ran out of turns and couldn't figure it out! Better luck next time!"
				break
			end 
		end
	end
end

def play_as_code_maker
	turns_remaining = 12
	known = 0
	while true
		puts "Colored pegs are: (R)ed, (O)range, (Y)ellow, (G)reen, (B)lue, (P)urple.\n" +
		     "Select a combination of four pegs to serve as the secret code."
		code = gets.chomp

		if valid_code?(code) == false
			puts "Secret code must be four letters from the list of colors."
		else
			while true
				guess = generate_code
				puts "The computer has guessed: "
				puts guess.join

				hit_enter_to_continue

				if check_guess(guess.join, code.upcase) == "bbbb"
					puts "The computer has guessed your code! Computer wins!"
					break
				end
				turns_remaining -= 1
				if turns_remaining == 0
					puts "The computer ran out of turns, you win!"
					break
				end 
			end
			break
		end
	end
end

while true
	puts "Welcome to Master Mind. Would you rather be the Code Maker or Code Breaker?\n" +
	     "1) Code Maker\n" +
	     "2) Code Breaker"
	choice = gets.chomp
	if choice.scan(/[12]/).count != 1
		puts "Invalid choice. Enter 1 or 2."
	else
		if choice.to_i == 1
			play_as_code_maker
			break
		else
			play_as_code_breaker
			break
		end
	end
end

