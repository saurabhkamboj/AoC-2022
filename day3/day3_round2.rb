require 'yaml'

PRIORITY = ("a".."z").to_a + ("A".."Z").to_a

def convert_string(str)
  str.split("\n")
end

def find_common_values(str)
  array = convert_string(str)
  common_values = []
  a = 0
  b = 1
  c = 2

  loop do
    break if c > (array.size - 1)
    common_values << (array[a].chars & array[b].chars & array[c].chars)
    a += 3
    b += 3
    c += 3
  end
  
  common_values
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
