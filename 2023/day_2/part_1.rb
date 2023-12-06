=begin
  Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
  Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
  Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
  Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
  Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green

  In game 1, three sets of cubes are revealed from the bag (and then put back again). The first set is 3 blue cubes and 4 red cubes; the second set is 1 red cube, 2 green cubes, and 6 blue cubes; the third set is only 2 green cubes.

  The Elf would first like to know which games would have been possible if the bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes?

  In the example above, games 1, 2, and 5 would have been possible if the bag had been loaded with that configuration. However, game 3 would have been impossible because at one point the Elf showed you 20 red cubes at once; similarly, game 4 would also have been impossible because the Elf showed you 15 blue cubes at once. If you add up the IDs of the games that would have been possible, you get 8.

  Determine which games would have been possible if the bag had been loaded with only 12 red cubes, 13 green cubes, and 14 blue cubes. What is the sum of the IDs of those games?
=end

=begin
  Breakdown
    - Cubes are either red, green or blue.
    - Bag contains the three in different numbers in each game.
    - Find the possibility of a game being played.
    - The balls need to be equal or less than the required.
    - Input > String
    - Output > Number
=end

CUBES = { 'red' => 12, 'green' => 13, 'blue' => 14 }

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
  game_configurations(array).select do |game|
    true unless CUBES.any? { |key, value| game[key].to_i > value }
  end.map { |game| game[:id].to_i }.sum
end

p determine_result(games)
