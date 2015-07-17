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

def correct_guess?(guess, code)
	return true if guess == code
end

def check_guess_black(guess, code)
	black_count = 0
	(0..3).each do |number|
		black_count += 1 if guess[number] == code[number]
	end
	black_count
end

def check_guess_white(guess, code)
	white_count = 0
	(0..3).each do |number|
		white_count += 1 if code.include?(guess[number])
	end
	white_count
end

puts "The code has been generated. Begin guessing..."
secret_code = generate_code

turns_remaining = 12

game_loop = true

while game_loop
	puts "Colors are: (R)ed, (O)range, (Y)ellow, (G)reen, (B)lue, (P)urple"
	puts "What is your guess?"
	guess = gets.chomp

 	if valid_guess?(guess) == false
 		puts "Guess must be four letters from the color list."
    else
    	guessed_colors = guess.split(//)
    	if correct_guess?(guessed_colors, secret_code)
    		puts "Good job! You've cracked the secret code!"
    		break
    	end
    	turns_remaining -= 1
    	
    	black = check_guess_black(guessed_colors, secret_code)
    	white = check_guess_white(guessed_colors, secret_code) - black

    	print guessed_colors
    	print secret_code
    	puts	
    	puts "black pegs: #{black}"
    	puts "white pegs: #{white}"

    	if turns_remaining == 0
    		puts "You ran out of turns and couldn't figure it out! Better luck next time!"
    		break
    	end 
    end
end
