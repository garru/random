require 'rubygems'
require 'optparse'
require File.join(File.dirname(__FILE__), 'lib', 'grid')
require File.join(File.dirname(__FILE__), 'strategies', 'hidden_singles')

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: sudoku.rb [options]"

  opts.on("-fFILE", "--file FILE", "Solve Grid File") do |f|
    options[:file] = f
  end
end.parse!

b = Grid.new(options[:file])
b.display
HiddenSingles.call(b)
b.display
HiddenSingles.call(b)
b.display
HiddenSingles.call(b)
b.display