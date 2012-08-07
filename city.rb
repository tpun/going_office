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

  def non_direct_connections city, visited
    @distances.keys.select { |c| c != city && (!visited.include? c) }
  end

  def distance city, visited=Set.new
    return 0 if city == self
    return Float::INFINITY if visited.include? self

    visited << self
    direct_distance   = @distances[city] || Float::INFINITY
    # childen_distances = non_direct_connections.
    #                       map    { |c|  @distances[c] +
    #                                    c.distance(city, visited.clone) }
    childen_distances = []
    non_direct_connections(city, visited).each do |c|
      next if @distances[c] > direct_distance
      childen_distances << (  @distances[c] +
                            (c.distance city, visited.clone))
    end
    puts "#{self.name} -> #{city.name}: direct: #{direct_distance} childen_distances: #{childen_distances.inspect}" if debug?

    [direct_distance, *childen_distances].min
  end

  def debug?
    false
  end
end