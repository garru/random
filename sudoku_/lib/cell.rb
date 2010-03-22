class Cell
  DEFAULT_CANDIDATES = (1..9).to_a
  attr_accessor :candidates, :value, :peers
  
  
  def initialize
    self.candidates = DEFAULT_CANDIDATES.dup
    self.peers = []
  end
  
  def value=(value)
    @value = DEFAULT_CANDIDATES.include?(value.to_i) ? value.to_i : nil
    self.peers.each{|peer| peer.remove_candidate(@value)} if @value
  end
  
  def remove_candidate(x)
    candidates.delete(x) unless value
  end
  
  def display
    if self.value
      self.value
    else
      DEFAULT_CANDIDATES.map{|x| self.candidates.include?(x) ? x : '.'}.join('')
    end
  end
end