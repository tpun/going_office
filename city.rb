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
    puts "#{self.name} -> #{city.name}" if debug?
    if @distances.empty? || (visited.include? self)
      puts "  end: #{@distances[city] || Float::INFINITY}" if debug?
      return @distances[city] || Float::INFINITY
    end

    visited << self
    direct_distance = @distances[city] || Float::INFINITY
    childen_distances = @distances.keys.
                          select {|c| c!= city }.
                          map    {|c| distance(c, visited) +
                                      c.distance(city, visited) }

    puts "#{self.name} -> #{city.name}: #{[direct_distance, *childen_distances].min} | direct: #{direct_distance}  childen: #{childen_distances}"  if debug?
    [direct_distance, *childen_distances].min
  end

  def debug?
    false
  end
end