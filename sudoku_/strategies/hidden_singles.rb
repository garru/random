class HiddenSingles
  def self.call(grid)
    grid.each do |cell|  
      next unless (!cell.value && cell.candidates.size == 1) 
      cell.value = cell.candidates.first
    end
  end
end