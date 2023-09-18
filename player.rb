class Player
  attr_accessor :name, :lives, :current_player

  def initialize(name)
    @lives = 3
    @name = name.upcase
    @current_player = false
  end

  def lose_a_life
    @lives -= 1
  end

end