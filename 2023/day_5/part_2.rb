# Some useful suggestion by Symbroson on Reddit

require_relative 'helper'

input = File.read('input.txt')

seeds, *maps = input.split("\n\n")
seed_ranges = seeds.split[1..].map(&:to_i).each_slice(2).map { _1.._1 + (_2 - 1)}
$map_ranges = maps.map { |map| map.split.map(&:to_i)[2..].each_slice(3).map { [_2.._2 + (_3 - 1), _1 - _2] }}

def locations(seed_range, index)
  return seed_range unless !!$map_ranges[index]

  locations = $map_ranges[index].select { |map| seed_range.intersect?(map[0]) }
  new_seed_ranges = !locations.empty? ? corresponding_locations(seed_range, locations) : [seed_range]
  new_seed_ranges.flat_map { |range| locations(range, index + 1) }
end

def corresponding_locations(seed_range, locations)
  locations.map do |location|
    (seed_range & location[0]) + location[1]
  end
end

p seed_ranges.flat_map { |seed_range| locations(seed_range, 0) }.map(&:first).min
