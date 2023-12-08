# - The numbers in the input is one number.
# - Calculate the number of ways a race can be won.

input = File.read('input.txt')

time, distance = input.split("\n").map { |row| row.split(':')[1].gsub(/\s/, '').to_i }

def ways(time, record_distance)
  (0..time).select do |current_time|
    speed, time_left = current_time, time - current_time
    speed * time_left > record_distance
  end.count
end

# Quadratic equation
=begin
  - time_left = time - speed
  - distance = time_left * speed
    - distance = (time - speed) * speed
    - speeed**2 - time*speed + distance = 0
    - (ax^2 + bx + c=0)

  - Quadratic formula
  - x1 = (-b + sqrt(b**2 - 4ac))/2a
  - x2 = (-b - sqrt(b**2 - 4ac))/2a
    - a = 1
    - x = speed
    - b = -time
    - c = distance + 1
=end

def ways(time, record_distance)
  max_speed = (time + Math.sqrt(time**2 - 4*(record_distance)))/2
  min_speed = (time - Math.sqrt(time**2 - 4*(record_distance)))/2

  max_speed.ceil - min_speed.floor - 1
end

p ways(time, (distance + 1))
