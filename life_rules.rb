class LifeRules
  attr_accessor :state

  def initialize(state, rows, cols)
    @state = state
    @rows = rows
    @cols = cols
  end

  def get_state_at(x, y)
    case
      when underpopulated?(x, y) then 0
      when living_happily?(x, y) then 1
      when overpopulated?(x, y)  then 0
      when can_reproduce?(x, y)  then 1
    end
  end



  private

  def is_alive?(x, y)
    @state[[x, y]] == 1
  end

  def is_dead?(x, y)
    !is_alive?(x, y)
  end

  def population_at(x, y)
    [
        @state[[(x - 1) % @cols, (y-1) % @rows]],
        @state[[(x - 1) % @cols, y]],
        @state[[(x - 1) % @cols, (y + 1) % @rows]],
        @state[[x, (y - 1) % @rows]],
        @state[[x, (y + 1) % @rows]],
        @state[[(x + 1) % @cols, (y - 1) % @rows]],
        @state[[(x + 1) % @cols, y]],
        @state[[(x + 1) % @cols, (y + 1) % @rows]]
    ].map(&:to_i).reduce(:+)
  end

  def underpopulated?(x, y)
    is_alive?(x, y) && population_at(x, y) < 2
  end

  def living_happily?(x, y)
    is_alive?(x, y) && ([2, 3].include? population_at(x, y))
  end

  def overpopulated?(x, y)
    is_alive?(x, y) && population_at(x, y) > 3
  end

  def can_reproduce?(x, y)
    is_dead?(x, y) && population_at(x, y) == 3
  end

end

