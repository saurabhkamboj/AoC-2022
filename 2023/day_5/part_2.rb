# - The seed line describes range of seed numbers
# - The line comes in pairs, within each pair
#   - The first value is start of range
#   - The second value is length of range
# - Consider all the numbers within these ranges as seeds.

=begin
  Breakdown
    - The seed array contains multiple pairs
    - Each pair consists of 2 numbers
    - The first number is the range start
      and the second number is the length.
    - Find all seeds between these ranges.

  Problem
    - Iterate over all odd numbers
    - Collect all numbers within the range
    - Return an array containing all the numbers

  Data structures
    - Array of seeds = ["79", "14", "55", "13"]
    - Jump on each iteration

  Algorithm
    - Iterate from 1 upto size of the array
      - Skip iterate if number is even
      - Add all numbers from array[num]..array[num] + array[num + 1]
    - Return the array and flatten it
=end

file = File.open('input.txt')

def format(file)
  file.read.split("\n\n")
  .map { |group| group.split(":") }
  .map do |group|
    [group[0], group[1].strip.split("\n")
    .map { |row| row.split }]
  end.to_h
end

# Collect all seed ranges
def all_ranges(numbers)
  numbers.map(&:to_i).select(&:even?).map do |index|
    (numbers[index]..(numbers[index] + numbers[index + 1] - 1))
  end
end

almanac = format(file)
seed_ranges = almanac['seeds'].flatten.map(&:to_i)
materials = almanac.except('seeds')

p seed_ranges

def locations(seed_ranges, materials)

end
