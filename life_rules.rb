class LifeRules
  attr_accessor :state

  def initialize(state, rows, cols)
    @state = state
    @rows = rows
    @cols = cols
  end

  def get_state_at(x, y)
    if underpopulated?(x, y)
      0
    elsif living_happily?(x, y)
      1
    elsif overpopulated?(x, y)
      0
    elsif can_reproduce?(x, y)
      1
    else
      0
    end
  end

  private

  def alive?(x, y)
    @state[[x, y]] == 1
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
    alive?(x, y) && population_at(x, y) < 2
  end

  def living_happily?(x, y)
    alive?(x, y) && ([2, 3].include? population_at(x, y))
  end

  def overpopulated?(x, y)
    alive?(x, y) && population_at(x, y) > 3
  end

  def can_reproduce?(x, y)
    !alive?(x, y) && population_at(x, y) == 3
  end

end

