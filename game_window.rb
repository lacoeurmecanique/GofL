require 'gosu'
require_relative 'cfg'


class GameWindow<Gosu::Window
  include Cfg
  def initialize
    super WIDTH, HEIGHT, false, 1000.0 / MAX_FPS
    self.caption = "Tutorial Game"
    @background_color = Gosu::Color.new(0xffdedede)
    @alive_color = Gosu::Color.new(0xff121212)
    @dead_color = Gosu::Color.new(0xffededed)
    @rows_count = WIDTH/CELL_SIZE
    @cols_count = HEIGHT/CELL_SIZE
    @random=false
    @cells=Hash.new; initialize_cells_hash
    @running=false

  end

  def initialize_cells_hash
    (0..@rows_count).each {|x| (0..@cols_count).each {|y| @cells[[x, y]]=@random?(rand(2)):0}}
  end

  def update
   if @running

   end
  end

  def draw
    fill_background
    @cells.each_pair do |key, value|
      draw_cell(key, value)
    end
  end

  def draw_cell(xy, val)
    if val == 1
      draw_quad(xy[0] * CELL_SIZE, xy[1] * CELL_SIZE, @alive_color,
                xy[0] * CELL_SIZE + (CELL_SIZE - 1), xy[1] * CELL_SIZE, @alive_color,
                xy[0] * CELL_SIZE + (CELL_SIZE - 1), xy[1] * CELL_SIZE + (CELL_SIZE - 1), @alive_color,
                xy[0] * CELL_SIZE, xy[1] * CELL_SIZE + (CELL_SIZE - 1), @alive_color)
    else
      draw_quad(xy[0] * CELL_SIZE, xy[1] * CELL_SIZE, @dead_color,
                xy[0] * CELL_SIZE + (CELL_SIZE - 1), xy[1] * CELL_SIZE, @dead_color,
                xy[0] * CELL_SIZE + (CELL_SIZE - 1), xy[1] * CELL_SIZE + (CELL_SIZE - 1), @dead_color,
                xy[0] * CELL_SIZE, xy[1] * CELL_SIZE + (CELL_SIZE - 1), @dead_color)
    end
  end


  def fill_background
    draw_quad(0, 0, @background_color,
              WIDTH, 0, @background_color,
              WIDTH, HEIGHT, @background_color,
              0, HEIGHT, @background_color)
  end

  def invert_cell(xy)
    @cells[xy] = (@cells[xy] == 0 ? 1 : 0)
  end

  def button_down(id)
    case id
      when Gosu::KB_ESCAPE then close
      when Gosu::KB_R then @random=true
        initialize_cells_hash
      when Gosu::KB_C then @random=false
        initialize_cells_hash
      when Gosu::KB_SPACE then @running=!@running
      when Gosu::MsLeft then invert_cell([mouse_x.to_i / CELL_SIZE,
                                                 mouse_y.to_i / CELL_SIZE])
    end
  end

  def needs_cursor?; true; end
end



GameWindow.new.show