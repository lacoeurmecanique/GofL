class LifeRules

  def is_alive?(x, y)
    state[[x, y]] == 1
  end

  def is_dead?(x, y)
    !is_alive?(x, y)
  end

  def population_at(x, y)
    [
        state[[x-1, y-1]],
        state[[x-1, y  ]],
        state[[x-1, y+1]],
        state[[x,   y-1]],
        state[[x,   y+1]],
        state[[x+1, y-1]],
        state[[x+1, y  ]],
        state[[x+1, y+1]]
    ].map(&:to_i).reduce(:+)
  end

  def is_underpopulated?(x, y)
    is_alive?(x, y) && population_at(x, y) < 2
  end

  def is_living_happily?(x, y)
    is_alive?(x, y) && ([2, 3].include? population_at(x, y))
  end

  def is_overpopulated?(x, y)
    is_alive?(x, y) && population_at(x, y) > 3
  end

  def can_reproduce?(x, y)
    is_dead?(x, y) && population_at(x, y) == 3
  end


  def get_state_at(x, y)
    case
      when is_underpopulated?(x, y) then 0
      when is_living_happily?(x, y) then 1
      when is_overpopulated?(x, y)  then 0
      when can_reproduce?(x, y)     then 1
    end
  end
end

