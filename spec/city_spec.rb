require 'pry'
require_relative '../city.rb'

describe City do
  subject { City.new 'city1' }

  describe '#connect' do
    let(:city2) { City.new 'city2' }
    let(:distance) { 10 }
    before { subject.connect city2, distance }

    it 'sets distance between two cities' do
      subject.distance(city2).should == distance
    end

    it 'connects both way' do
      city2.distance(subject).should == distance
    end

    let(:new_distance) { distance + 10 }
    it 'can reset distance' do
      subject.connect city2, new_distance

      subject.distance(city2).should == new_distance
    end
  end

  describe '#disconnect' do
    let(:city2) { City.new 'city2' }
    let(:distance) { 10 }
    before { subject.connect city2, distance }

    it 'disconnects two cities' do
      subject.disconnect city2

      subject.distance(city2).should == Float::INFINITY
    end
  end

  describe '#distance' do
    let(:city1) { City.new 'city1' }
    let(:city2) { City.new 'city2' }
    let(:city3) { City.new 'city3' }
    let(:city4) { City.new 'city4' }
    let(:city5) { City.new 'city5' }
    let(:city6) { City.new 'city6' }

    it 'follows thru the path' do
      city1.connect city2, 12
      city2.connect city3, 23

      city1.distance(city3).should == 12 + 23
    end

    it 'returns Infinity if not found' do
      city1.distance(City.new 'city4').should == Float::INFINITY
    end

    it 'works even if start and destination is not the ends' do
      city1.connect city2, 12
      city2.connect city3, 23
      city3.connect city4, 34
      city4.connect city5, 45

      city2.distance(city4).should == 23 + 34
    end

    it 'outputs the shortest distance' do
      city1.connect city2, 12
      city2.connect city3, 23
      city1.connect city3, 100

      city1.distance(city3).should == 12 + 23
    end

    it 'finds the shortest in a star pattern' do
      cities = [city1, city2, city3, city4, city5]
      cities.each do | s |
        cities.each do | d |
          s.connect d, 1 if s != d
        end
      end
      city1.disconnect city3 # no direct path
      city6.connect city3, 1

      city1.distance(city6).should == 3
    end
  end
end