# - The numbers in the input is one number.
# - Calculate the number of ways a race can be won.

input = File.read('input.txt')

time, distance = input.split("\n").map { |row| row.split(':')[1].gsub(/\s/, '').to_i }

def ways_product(time, record_distance)
  (0..time).select do |current_time|
    speed, time_left = current_time, time - current_time
    speed * time_left > record_distance
  end.count
end

p ways_product(time, distance)
