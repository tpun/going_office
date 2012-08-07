require 'pry'
require_relative 'city'

input = ARGV.shift || 'input00.txt'
output= ARGV.shift || 'output00.txt'
file = File.new input
truth= File.new output

n, m = file.readline.split ' '
N, M = n.to_i, m.to_i
cities = (0..N-1).map {|c| City.new "city#{c}" }
M.times do
  u, v, w = file.readline.split ' '
  cities[u.to_i].connect cities[v.to_i], w.to_i
end

s,d = file.readline.split ' '
S, D = cities[s.to_i], cities[d.to_i]

Q = file.readline.to_i
Q.times do
  u, v = file.readline.split ' '
  u = cities[u.to_i]
  v = cities[v.to_i]

  original = u.distance v
  # puts "Disconnecting #{u.name} and #{v.name} original: #{original}"
  u.disconnect v

  shortest = S.distance D
  print "#{shortest}"
  if truth
    ground_truth = truth.readline.to_i
    print " *** Failed! Correct answer: #{ground_truth}" if shortest!=ground_truth
    puts
  end
  u.connect v, original
end

file.close
truth.close if truth
