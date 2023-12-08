# - You have a set amount of time.
# - You win the race if your boat goes farthest.
# - Go farther in each race than the current record.
# - The sheet of paper lists:
#   - Time allowed for each race
#   - Best distance ever recorded

# - Each boat has a button on the top:
#   - Holding the button charges the boat.
#   - Releasing it allows it to move.
# - Boat moves faster if button is held longer
# - Time spent holding it counts against the total time.
# - You only hold button at start of the race.
#   - The boat does not move until released.

# Example input:
# Time:      7  15   30
# Distance:  9  40  200

# - Starting speed of 0 millimeters per milliseconds.
# - For each millisecond of hold speed increases by 1.

=begin
  Breakdown
    - Determine the number of ways a record can be broken.
    - The record is broken in the following manner:
      - To cover a distance of 9 in 7 milliseconds
        - The boat needs a speed of atleast 2
        - Given that 2 * 5 (remaining time) = 10 > 9
    - Calculate this for each distane.
    - Return the product of all the numbers.

  Data structure
    - Iterate over time
    - 0 to 7
      - Speed = 0
      - Time left = Max - Speed > 7 - 0
      - Distance = Speed * Time left

      - (Jumping 2 iterations) Speed = 3
      - Time left = 7 - 3 > 4
      - Distance = 12

  Problem
    - Iterate over each time, distance pair.
    - Iterate over & select time if record breaks.
    - Return count of times.
    - Return the product of counts.

  Algorithm
    - To format the data
      - time, distance = input.split.map.split(':')[1].split.map(&:to_i)
      - time_distance_pairs = time.zip(distance).to_h
    - Iterate over each time, distance pair
      - On each iteration iterate from 0 till time
        - speed = current_time, time_left = time - speed
        - distance_covered = speed * time_left
        - select if distance_covered is greater than distance
        - return the count of time's selected
      - Return the product of all returned counts.
=end

input = File.read('input.txt')

time, distance = input.split("\n").map { |row| row.split(':')[1].split.map(&:to_i) }
time_distance = time.zip(distance).to_h

def ways_product(pairs)
  pairs.map do |time, record_distance|
    (0..time).select do |current_time|
      speed, time_left = current_time, time - current_time
      speed * time_left > record_distance
    end.count
  end.inject(&:*)
end

p ways_product(time_distance)
