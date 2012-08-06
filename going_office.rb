require 'pry'
require_relative 'city'

input = ARGV.shift
file = File.new input

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
1.times do
  u, v = file.readline.split ' '
  u = cities[u.to_i]
  v = cities[v.to_i]

  original = u.distance v
  puts "Disconnecting #{u.name} and #{v.name} original: #{original}"
  u.disconnect v

  puts S.distance D

  u.connect v, original
end
file.close
