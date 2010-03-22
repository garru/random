require File.join(File.dirname(__FILE__), 'cell')
require File.join(File.dirname(__FILE__), 'peer')

class Grid
  attr_accessor :cells, :rows, :cols, :nonets
  NUM_NONETS = NUM_ROWS = NUM_COLS = 9
  NUM_CELLS = NUM_ROWS * NUM_COLS
  DEFAULT_CANDIDATES = (1..9).to_a

  def initialize(file)
    grid_input = File.open(file).readline
    raise ArgumentError.new("Invalid Grid format length => #{grid_input.length}") if grid_input.length != NUM_CELLS
    self.rows = Array.new(NUM_ROWS){ Row.new }
    self.cols = Array.new(NUM_COLS){ Col.new }
    self.nonets = Array.new(NUM_NONETS){ Nonet.new }
    self.cells = Array.new(NUM_CELLS){Cell.new}
    #set up cells
    NUM_CELLS.times do |x|
      cell = self.cells[x]
      self.row(x) << cell
      self.col(x) << cell
      self.nonet(x) << cell
    end
    
    NUM_CELLS.times do |x|
      self.cells[x].value = grid_input[x].chr
    end
  end

  def cell(row, col)
    self.cells[row*NUM_ROWS + col]
  end

  def row(cell_idx)
    rows[cell_idx/NUM_ROWS]
  end

  def col(cell_idx)
    cols[cell_idx%NUM_COLS]
  end

  def nonet(cell_idx)
    nonets[(cell_idx/(NUM_ROWS*3)*3) + (cell_idx % NUM_ROWS/3)]
  end

  def each(&proc)
    self.cells.each(&proc)
  end

  def display
    NUM_ROWS.times do |x| 
      puts "#{display_row(x)}"
      if ((x+1) % 3 == 0)
        puts "====================================================="
      else
        puts "-----------------------------------------------------"
      end
      puts ""
    end
  end
  
  def display_row(r)
    row = ""
    NUM_COLS.times do |y|
      row << " #{cell(r,y).display} "
      row << " || " if y < NUM_COLS - 1 && ((y+1) % 3 == 0)
      row << " | " if y < NUM_COLS - 1 && ((y+1) % 3 != 0)
    end
    row
  end
end