require 'set'

class City
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

    @distances[city] = nil
    city.disconnect self
  end

  def distance city, visited=Set.new
    if @distances.empty? || (visited.include? self)
      return @distances[city] || Float::INFINITY
    end

    visited << self
    direct_distance = @distances[city] || Float::INFINITY
    childen_distances = @distances.keys.
                          select {|c| c!= city}.
                          map {|c| distance(c, visited) + c.distance(city, visited)}

    [direct_distance, *childen_distances].min
  end
end