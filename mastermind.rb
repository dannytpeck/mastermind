# Colors: (R)ed (G)reen (B)lue (Y)ellow (P)urple (O)range (1-6)
# Example codes: ROGB, ROOY, YPOG, YRRG

def generate_code
	code = []
	4.times do 
		result = rand(6)
		code << "R" if result == 0
		code << "O" if result == 1
		code << "Y" if result == 2
		code << "G" if result == 3
		code << "B" if result == 4
		code << "P" if result == 5
	end
	code
end

def valid_guess?(guess)
	if guess.downcase.scan(/[roygbp]/).count == 4
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

puts "The code has been generated. Begin guessing..."
secret_code = generate_code

turns_remaining = 12

game_loop = true

while game_loop
	puts "Colored pegs are: (R)ed, (O)range, (Y)ellow, (G)reen, (B)lue, (P)urple.\n" + 
	      "Response pegs are colored (b)lack for a successful guess and (w)hite.\n" +
	      "when the color is somewhere in the code but in the wrong place.\n\n" +
	      "What is your guess?"
	guess = gets.chomp

	if valid_guess?(guess) == false
		puts "Guess must be four letters from the color list."
	else
		guessed_colors = guess.split(//)
		turns_remaining -= 1

		if check_guess(guessed_colors, secret_code) == "bbbb"
			puts "Good job! You've cracked the secret code!"
			break
		end

		print guessed_colors #debug: shows guess and code
		print secret_code #debug
		puts
		puts "Results: " + check_guess(guessed_colors, secret_code)

		if turns_remaining == 0
			puts "You ran out of turns and couldn't figure it out! Better luck next time!"
			break
		end 
	end
end
