class Game
    #player1 = "X"
    #player2 = "O"
    attr_accessor :game, :winner

    def initialize
        @game = Array.new(3) {Array.new(3, "-")}
        @winner = false
        @turn = 0
    end
    
    def draw_board
        @game.each_with_index do |block, i|
            puts "#{block[0]} | #{block[1]} | #{block[2]}"
        end
        puts
    end

    def play(player, position1, position2)
        if player == "player1"
            @game[position1.to_i][position2.to_i] == "-" ? @game[position1.to_i][position2.to_i] = "X" : error(player)
        elsif player == "player2"
            @game[position1.to_i][position2.to_i] == "-" ? @game[position1.to_i][position2.to_i] = "O" : error(player)
        end
        check(player)
    end

    def check(player)
        tictac = player == "player1" ? "X" : "O"
        i = 0
        while i < 3 
            if @game[i][0] == @game[i][1] && @game[i][0] == @game[i][2] && @game[i][0]  == tictac
                #Checks the rows for a winner
                puts `clear`
                self.draw_board
                puts "#{player} IS A WINNER"
                @winner = true
                break
            elsif @game[0][i] == @game[1][i] && @game[0][i] == @game[2][i] && @game[0][i]  == tictac
                #Checks the columns for a winner
                puts `clear`
                self.draw_board
                puts "#{player} IS A WINNER"
                @winner = true
                break
            #Next 2 elsif statements check the diagonals
            elsif @game[0][0] == @game[1][1] && @game[0][0] == @game[2][2] && @game[0][0]  == tictac
                puts `clear`
                self.draw_board
                puts "#{player} IS A WINNER"
                @winner = true
                break
            elsif @game[2][0] == @game[1][1] && @game[2][0] == @game[0][2] && @game[2][0]  == tictac
                puts `clear`
                self.draw_board
                puts "#{player} IS A WINNER"
                @winner = true
                break
            end
            i += 1
        end 
        #Increment turn to check if theres a tie.
        #If there is no winner on the 9th round, it's automatically a tie
        @turn += 1
        if @turn >= 9 
            puts `clear`
            self.draw_board
            puts "THE GAME IS A TIE"
            @winner = true
        end
    end

    def input(player)
        loop do
            print "#{player}: "
            @choice = gets.chomp
            @choice = @choice.split(" ")
            break if @choice[0].to_i.between?(0,2) && @choice[1].to_i.between?(0,2)
        end
        self.play(player, @choice[0], @choice[1])

    end

    def error(player)
        print `clear`
        puts "Error, space already taken"
        self.draw_board
        self.input(player)
    end
end

def play_game()
    x = Game.new()
    until x.winner == true
        #puts `clear`
        x.draw_board
        x.input("player1")
        #puts `clear`
        break if x.winner == true
        x.draw_board
        x.input("player2")
        break if x.winner == true
    end
end

play_game()
