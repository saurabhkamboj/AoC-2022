=begin
  The engineer explains that an engine part seems to be missing from the engine, but nobody can figure out which one. If you can add up all the part numbers in the engine schematic, it should be easy to work out which part is missing.

  The engine schematic (your puzzle input) consists of a visual representation of the engine. There are lots of numbers and symbols you don't really understand, but apparently any number adjacent to a symbol, even diagonally, is a "part number" and should be included in your sum. (Periods (.) do not count as a symbol.)

  Here is an example engine schematic:

  467..114..
  ...*......
  ..35..633.
  ......#...
  617*......
  .....+.58.
  ..592.....
  ......755.
  ...$.*....
  .664.598..

  In this schematic, two numbers are not part numbers because they are not adjacent to a symbol: 114 (top right) and 58 (middle right). Every other number is adjacent to a symbol and so is a part number; their sum is 4361.
=end

=begin
  Problem
    - Add the indices of numbers in an array.
    - Select the numbers whose indices are adjacent to a symbol (Except '.').
    - Return the sum of selected numbers.

  Data structures
    - An example row > ["4", "6", "7", ".", ".", "1", "1", "4", ".", "."]
    - The numbers here are 4, 6 and 7
    - [row 0, column 0], [row 0, column 1], [row 0, column 2]
    - Sample coordinates > [[0, 0], [0, 1], [0, 2]]

    - Co-ordinatea to check for every number
      - [0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]
=end

file = File.open('input.txt').readlines.map(&:chomp)
matrix = file.map { |row| row.split('') }

def parts_sum(matrix)
  all_numbers = get_number_coordinates(matrix)

  all_numbers.each_with_object([]) do |number, result|
    next unless neighbour_of_symbol?(number, matrix)

    number_string = number.map do |digit|
      matrix[digit[0]][digit[1]]
    end.join

    result << number_string.to_i
  end.sum
end

def neighbour_of_symbol?(number, matrix)
  neighbours = [[-1, -1], [0, -1], [1, -1], [1, 0],
                [1, 1], [0, 1], [-1, 1], [-1, 0]]

  number.any? do |digit|
    neighbours.any? do |neighbour|
      position = [digit[0] + neighbour[0], digit[1] + neighbour[1]]

      in_matrix?(position, matrix) && symbol?(position, matrix)
    end
  end
end

def in_matrix?(position, matrix)
  position[0].between?(0, matrix.length - 1) &&
    position[1].between?(0, matrix[0].length - 1)
end

def symbol?(position, matrix)
  matrix[position[0]][position[1]].match?(/[^0-9.]/)
end

def get_number_coordinates(matrix)
  matrix.each_with_index.with_object([]) do |(elements, row), result|
    current_number = []
    elements.each_with_index do |char, column|
      if char.match?(/[0-9]/)
        current_number << [row, column]
      elsif !current_number.empty?
        result << current_number
        current_number = []
      end
    end

    result << current_number unless current_number.empty?
  end
end

p parts_sum(matrix)
