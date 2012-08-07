require 'set'

class City
  attr_reader :name
	def initialize name
		@name = name
    @distances = {}
	end

  def connect city, distance
    return if @distances[city] == distance

    @distances[city] = distance
    city.connect self, distance
  end

  def disconnect city
    return if @distances[city] == nil

    @distances.delete city
    city.disconnect self
  end

  def distance city, visited=Set.new
    return 0 if city == self
    return Float::INFINITY if visited.include? self

    visited << self
    direct_distance   = @distances[city] || Float::INFINITY
    childen_distances = @distances.keys.
                          select { |c| c != city && (!visited.include? c) }.
                          map    { |c|  @distances[c] +
                                       c.distance(city, visited.clone) }
    puts "#{self.name} -> #{city.name}: direct: #{direct_distance} childen_distances: #{childen_distances.inspect}" if debug?

    [direct_distance, *childen_distances].min
  end

  def debug?
    false
  end
end