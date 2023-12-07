# - Almanac lists all the seeds that need to be planted.
# - It also lists the following:
#   - What kind of soil to use for the seed
#   - What kind of fertiliser to use for the soil
#   - What type of water to use for fertilizer etc
# - All of these are identified with a number.
# - These numbers are reused across types.

# - Convert 'the source' to 'the destination'
# - Example: 50 98 2
#   - Destination range start is 50
#   - Source range start is 98
#   - Range length is 2
#   - Source 98 corresponds to destination 50
#   - Source 99 corresponds to destination 51
# - Find the lowest location number that
#   corresponds to any of the seed numbers.

=begin
  Breakdown
    - Every two "\n\n" contain a group
    - Each group has a header and n number of rows
    - Each row has 3 numbers except first

    - One group from material values contains destination
    - group = select_group(value)
    - value.select { |group|
      group = group.map(&:to_i)
      (group[1]..group[1] + group[2]).include?(source) }

  Problem
    - Create a hash with headers as key & rows as value(s)
    - Find location for each seed in the first k-v pair.
    - Return the lowest of all locations.

  Data structures
    - Find 79 in these groups: 50 98 2, 52 50 48
      - source = 79
      - source_range = 50..50+48
      - destination_range = 52..52+48
      - destination = if (destination_range).include?(source)
          destination_range.first + (source_range.last - source)
        else
          seed

  Algorithm
    - Iterate over all seeds
      - Assign the current seed to `source`
      - Iterate over all materials
        - On each iterate use source to calculate destination
        - Re-assign source to destination
      - Return source on each iteration
    - Return the source with the lowest value
=end

file = File.open('input.txt')

def format(file)
  file.read.split("\n\n")
  .map { |group| group.split(":") }
  .map do |group|
    [group[0], group[1].strip.split("\n")
    .map { |row| row.split.map(&:to_i) }]
  end.to_h
end

almanac = format(file)
seeds = almanac['seeds'].flatten
maps = almanac.except('seeds').values

def locations(seeds, maps)
  seeds.map do |seed|
    source = seed.to_i
    maps.each do |material_maps|
      map = select_group(material_maps, source)
      (source = ((map[0] - map[1]) + source)) if !!map
    end

    source
  end
end

def select_group(maps, source)
  maps.find do |map|
    (map[1]..map[1] + (map[2] - 1)).include?(source)
  end
end

p locations(seeds, maps).min
