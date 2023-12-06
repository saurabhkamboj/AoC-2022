file = File.open('input.txt').readlines.map(&:chomp)
matrix = file.map { |row| row.split('') }

def parts_sum(matrix)
  all_numbers = get_number_coordinates(matrix)
  gears = find_gears(all_numbers, matrix)

  gears.each_with_object([]) do |(_, value), result|
    (result << value[0] * value[1]) if value.length == 2
  end.sum
end

def find_gears(numbers, matrix)
  numbers.each_with_object({}) do |number, result|
    number_string = get_number(number, matrix).to_i

    neighbour_gears(number, matrix).each do |gear|
      if result.key?(gear)
        result[gear] << number_string
      else
        result[gear] = [number_string]
      end
    end
  end
end

def neighbour_gears(number, matrix)
  neighbours = [[-1, -1], [0, -1], [1, -1], [1, 0],
                [1, 1], [0, 1], [-1, 1], [-1, 0]]

  number.each_with_object([]) do |digit, result|
    neighbours.each do |neighbour|
      position = [digit[0] + neighbour[0], digit[1] + neighbour[1]]

      result << position if in_matrix?(position, matrix) &&
                            gear?(position, matrix) &&
                            !result.include?(position)
    end
  end
end

def in_matrix?(position, matrix)
  position[0].between?(0, matrix.length - 1) &&
    position[1].between?(0, matrix[0].length - 1)
end

def gear?(position, matrix)
  matrix[position[0]][position[1]] == '*'
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

def get_number(number, matrix)
  number.map do |digit|
    matrix[digit[0]][digit[1]]
  end.join
end

p parts_sum(matrix)
