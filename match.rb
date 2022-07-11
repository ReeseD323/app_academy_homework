puts 'FUCK'
def fib(n)
    if n== 1 or n== 0
        return 1
    else
        fib(n-1) + fib(n-2)
    end
end
def my_flatten(arr)
    flattened= []
    arr.each do |el|
        if el.class == Array
            flattened.concat(my_flatten(el))
        else 
            flattened.append el
        end
    end
    flattened
end

=begin 

The Game should have instance variable for the Board and the 
previously-guessed position (if any). It should also have methods for 
managing the Board-Player interaction. You may want a play loop that runs
 until the game is over. Inside the loop, you should render the board,
     prompt the player for input, and get a guessed pos. Pass this pos to 
     a make_guess method, where you will handle the actual memory/matching
      logic. Some tips on implementing this:

If we're not already checking another Card, leave the card at guessed_pos
 face-up and update the previous_guess variable.
If we are checking another card, we should compare the Card at guessed_pos
 with the one at previous_guess.
If the cards match, we should leave them both face-up.
Else, flip both cards face-down.
In either case, reset previous_guess.
It wouldn't be an interesting game if the player could see their previous 
moves. Run system("clear") before rendering the Board. This will hide any 
previous output from the player. sleep(n) will pause the program for n
 seconds. Use this method to (temporarily) show the player an incorrect
  guess before flipping the Cards face-down again. 
=end 
class Card
    values= ("A".."Z").to_a
    def initialize(faceval)
        @faceval= faceval
        @headup
    end
    def hide
        @headup= false
    end
    def reveal
        @headup= true
    end
    def to_s
    end
    def faceval
        return @faceval
    end
    def headup
        return @headup
    end 
    def showface
        @headup = true
    end
    def ==(otherfaceval)
        if @faceval == otherfaceval
            return true
        end
        return false
    end
    def shuffled(numcards)
        cards= []
        num_pairs = numcards / 2
        spareneeded= false
        if numcards % 2 == 1
            spareneeded=true
            puts "spareneeded"
        end
        puts num_pairs
        (1..num_pairs).each do |i| 
            values= ("A".."Z").to_a
            faceval= values.shuffle
            cards.append Card.new(faceval[0])
            cards.append Card.new(faceval[0])
        end
        if spareneeded == true
            cards.append Card.new("B")
        end
        return cards.shuffle
    end
    def shuffeled_one
        values= ("A".."Z").to_a
        faceval= values.shuffle
        return Card.new(faceval[0])
    end
end

class Board
    def initialize(size) 
        @size = size
        @board =  Array.new(size) {Array.new(size)}
        @numpairs= (size **2)/2
        @pairsfound= 0
        populate
    end
    def board
        return @board
    end
    def numpairs
        return @numpairs
    end
    def pairfound
        @pairsfound += 1 
    end
    def populate
        cardsneeded= (@size ** 2) 
        i= 0
        items = Card.new(0).shuffled(cardsneeded)
        (0...@size).each do |y|
            (0...@size).each do |x|
                @board[y][x]= items[i]
                i +=1
            end
        end
    end
    def setnumpairs(num)
        @numpairs = num
    end
    def render
        (0..10).each {|a| puts ""}
        showlist= []
        for row in @board
            rowcontents= []
            for item in row
                if item.headup == true
                    rowcontents.append item.faceval
                else 
                    rowcontents.append "x"
                end
            end
            showlist.append rowcontents
        end
        showlist.each {|i| p i}
    end
    def won? 
        if @numpairs == @pairsfound
            return true
        end
        false
    end
    def reveal(guessed_pos)
        x= guessed_pos[0]
        y= guessed_pos[1]
        @board[x][y].showface
    end
end

class Humanplayer
    def initialize
    end
    def prompt 
        return gets
    end
end

class Game
    def initialize 
        @matchesmade= 0 
        @over = false
    end
    Game_board = Board.new(3)
    Game_board.populate
    Game_board.render
    def guess
        puts "enter row: "
        row = Humanplayer.new.prompt 
        puts "Enter column: "
        column= Humanplayer.new.prompt
        guessed_coordinate=  [row.to_i, column.to_i]
        puts "seelected position is : ", guessed_coordinate
        puts ''
        return guessed_coordinate
    end
    def attempt
        puts "Lets take a guess"
        firstguess= self.guess
        Game_board.reveal(firstguess)
        Game_board.render
        puts "Ok time for your second guess"
        secondguess= self.guess
        Game_board.reveal(secondguess)
        Game_board.render
        if Game_board.board[firstguess[0]][firstguess[1]].faceval == Game_board.board[secondguess[0]][secondguess[1]].faceval
            Game_board.pairfound
            puts "MATCH FOUND!!!"  
        else
            puts "not a match sorry"
            sleep(3)
            Game_board.board[firstguess[0]][firstguess[1]].hide
            Game_board.board[secondguess[0]][secondguess[1]].hide
            Game_board.render
        end
    end
    puts @over
    def play 
        while @over== false
            puts "Game started"
            while 1 == 1
                attempt
                if Game_board.won? == true
                    puts "CONGRATS!!!! YOU WON"
                    @over= true
                end
            end
        end
    end
end



card= Card.new(1)


dude= Humanplayer.new
board= Board.new(3)
puts "board is " , board

puts play = Game.new
puts play.play

