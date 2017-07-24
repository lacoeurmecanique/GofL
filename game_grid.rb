class GameGrid
  include Cfg
  attr_accessor :cells, :random
  attr_reader :rows_count, :cols_count

  def initialize
    @rows_count = HEIGHT/CELL_SIZE
    @cols_count = WIDTH/CELL_SIZE
    @cells={}
    @random=false
    initialize_cells_hash
  end

  def initialize_cells_hash
    (0..@rows_count).each {|y| (0..@cols_count).each {|x| @cells[[x, y]]=@random ? (rand(2)) : 0}}
  end

end