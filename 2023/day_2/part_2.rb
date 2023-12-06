input = open('input.txt', 'r')
games = input.readlines.map(&:chomp)

def game_configurations(array)
  array.map do |string|
    parts = string.split(': ')
    hash = Hash.new(0).merge({ id:parts.first.split()[1] })
    parts.last.split('; ').each_with_object(hash) do |set, result|
      set.split(', ').each do |cube|
        cube_parts = cube.split
        if result.key?(cube_parts[1])
          if cube_parts[0].to_i > result[cube_parts[1]].to_i
            result[cube_parts[1]] = cube_parts[0]
          end
        else
          result[cube_parts[1]] = cube_parts[0]
        end
      end
    end
  end
end

def determine_result(array)
  game_configurations(array).map do |game, array|
    game.each_with_object([]) do |(key, value), array|
      array << value.to_i if ['green', 'blue', 'red'].include?(key)
    end.inject(:*)
  end.sum
end

p determine_result(games)
