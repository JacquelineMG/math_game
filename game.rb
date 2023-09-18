require './player'
require './question'

class Game 

  def initialize

    # set initial round number:
    
    @round = 1

    # Array of greetings for users:

    greetings = ["Welcome to the game,", "Get ready to add,", "Hope you're good at math,", "Nice to meet you,", "Hello,", "Howdy,", "Power up your calculator,"]


    # Get and set users' names:

    print "Enter player one's name: "
    player_one_name = gets.chomp

    @player1 = Player.new(player_one_name)
    puts "#{greetings.sample} #{@player1.name}!"
    puts ""


    print "Enter player two's name: "
    player_two_name = gets.chomp

    @player2 = Player.new(player_two_name)
    puts "#{greetings.sample} #{@player2.name}!"
    puts ""

    # Randomly set first player
    players = [@player1, @player2]
    first = players.sample
    first.current_player = true

    puts ""
    puts "----- ROUND #{@round} -----"
    puts ""
  end


# method to increment round number count:

  def next_round 
    @round += 1
  end


  # method to generate next question and catch user's response:

  def make_question
    @question = Question.new

    if @player1.current_player 
      print "#{@player1.name}: #{@question.question} 
      >> "
      @response = gets.chomp

    else
      print "#{@player2.name}: #{@question.question} 
      >> "
      @response = gets.chomp
    end
  end


# method to check user's answer:

  def check_answer

    right = "Well done, "
    wrong = "Sorry. That's not the answer,"

    if @response.to_i == @question.answer

      # puts right answer message and switch current user:
      if @player1.current_player
        puts "#{right} #{@player1.name}!"

        @player1.current_player = false        
        @player2.current_player = true
      else 
        puts "#{right} #{@player2.name}!"

        @player1.current_player = true
        @player2.current_player = false
      end
    
    else

      # puts wrong answer message, decrement wrong user's score and switch current user:

      if @player1.current_player
        puts "#{wrong} #{@player1.name}." 

        @player1.lose_a_life

        @player1.current_player = false
        @player2.current_player = true
      
      else
        puts "#{wrong} #{@player2.name}."

        @player2.lose_a_life

        @player1.current_player = true
        @player2.current_player = false
      end
    end

    puts ""
    puts "SCORE: #{@player1.name}: #{@player1.lives}/3  VS  #{@player2.name}: #{@player2.lives}/3"
    puts ""

    #call game over check:
    game_over
  end


  # method to call next round's question and check answer:

  def round
    make_question
    check_answer
  end


  # check scores to end game or move to next round:

  def game_over
    if @player1.lives == 0
      puts ""
      puts "----- GAME OVER -----"
      puts ""
      puts "After #{@round} gruelling rounds, #{@player2.name} wins with a score of #{@player2.lives}/3"
      puts "Good bye!"
    elsif @player2.lives == 0
      puts ""
      puts "----- GAME OVER -----"
      puts ""
      puts "After #{@round} gruelling rounds, #{@player1.name} wins with a score of #{@player1.lives}/3"
      puts "Good bye!"
      puts ""
    else

      # call method to increment round number count:
      next_round 

      puts ""
      puts "----- ROUND #{@round} -----"
      puts ""

      # start next round:
      round
    end
  end

end