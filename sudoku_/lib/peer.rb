require 'delegate'

class Peer
  attr_accessor :cells, :candidates
  
  def initialize
    self.cells = []
  end
  
  def each(&proc)
    self.cells(&proc)
  end
  
  def <<(cell)
    cell.peers << self
    self.cells << cell
  end
  
  def remove_candidate(num)
    cells.each do |cell|
      cell.remove_candidate(num)
    end
  end
  
  def to_s
    cells.map{|x| "#{x.object_id}"}
  end
end

class Row < Peer; end
class Col < Peer; end
class Nonet < Peer; end