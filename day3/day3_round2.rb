require 'yaml'

PRIORITY = ("a".."z").to_a + ("A".."Z").to_a

def convert_string(str)
  array = []

  str.split("\n").each_slice(3) { |a| array << a }

  array
end

def find_common_values(str)
  convert_string(str).map do |arr|
    arr[0].chars & arr[1].chars & arr[2].chars
  end
end

def total_value(str)
  total = 0
  find_common_values(str).flatten.map do |i|
    total += (PRIORITY.index(i) + 1)
  end
  total
end

string = YAML.load_file("day3_input.yml")

p total_value(string)
