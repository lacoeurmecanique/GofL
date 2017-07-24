require 'gosu'
require_relative 'cfg'
require_relative 'game_grid'
require_relative 'life_rules'

class GameWindow<Gosu::Window
  include Cfg

  def initialize
    super WIDTH, HEIGHT, false, 1000.0 / MAX_FPS
    self.caption = "Game of life"
    @background_color = Gosu::Color.new(0xffdedede)
    @alive_color = Gosu::Color.new(0xff121212)
    @dead_color = Gosu::Color.new(0xffededed)
    @running = false
    @grid = GameGrid.new
    @rules = LifeRules.new(@grid.cells, @grid.rows_count, @grid.cols_count)
    @tick = 0
    @font = Gosu::Font.new(25)
  end

  def update
    #p @grid.cells
    if @running
      sleep DURATION
      @rules.state = @grid.cells
      @grid.cells = get_state_hash
      @tick += 1
    end
  end

  def get_state_hash
    h = {}
    @grid.cells.each_key { |key| h[key] = @rules.get_state_at(*key) }
    h
  end

  def draw
    fill_background
    @font.draw("Ticks: #{@tick}", 0, 0, 3, 1.0, 1.0, Gosu::Color::BLACK)
    @grid.cells.each_pair { |key, value| draw_cell(*key, value) }
  end

  def draw_cell(x, y, val)
    if val == 1
      draw_quad(x * CELL_SIZE, y * CELL_SIZE, @alive_color,
                x * CELL_SIZE + (CELL_SIZE - 1), y * CELL_SIZE, @alive_color,
                x * CELL_SIZE + (CELL_SIZE - 1), y * CELL_SIZE + (CELL_SIZE - 1), @alive_color,
                x * CELL_SIZE, y * CELL_SIZE + (CELL_SIZE - 1), @alive_color)
    else
      draw_quad(x * CELL_SIZE, y * CELL_SIZE, @dead_color,
                x * CELL_SIZE + (CELL_SIZE - 1), y * CELL_SIZE, @dead_color,
                x * CELL_SIZE + (CELL_SIZE - 1), y * CELL_SIZE + (CELL_SIZE - 1), @dead_color,
                x * CELL_SIZE, y * CELL_SIZE + (CELL_SIZE - 1), @dead_color)
    end
  end

  def fill_background
    draw_quad(0, 0, @background_color,
              WIDTH, 0, @background_color,
              WIDTH, HEIGHT, @background_color,
              0, HEIGHT, @background_color)
  end

  def invert_cell(x, y)
    #@grid.cells[[x, y]] = @grid.cells[[x, y]] == 0 ? 1 : 0
    puts "xy: #{x}+#{y}"
    @grid.cells[[x, y]] = @grid.cells[[x, y]].zero? ? 1 : 0
  end

  def clear_grid
    @grid.random = false
    @tick = 0
    @grid.initialize_cells_hash
  end

  def randomize_grid
    @grid.random = true
    @grid.initialize_cells_hash
  end

  def button_down(id)
    case id
      when Gosu::KB_ESCAPE then close
      when Gosu::KB_R      then randomize_grid
      when Gosu::KB_C      then clear_grid
      when Gosu::KB_SPACE  then @running = !@running
      when Gosu::MsLeft    then invert_cell(mouse_x.to_i / CELL_SIZE,
                                                 mouse_y.to_i / CELL_SIZE)
    end
  end

  def needs_cursor?; true; end
end



GameWindow.new.show