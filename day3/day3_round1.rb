require 'yaml'

PRIORITY = ("a".."z").to_a + ("A".."Z").to_a

def convert_string(str)
  str.split("\n").map do |i|
    [i[0, (i.size/2)]] + [i[(i.size/2)..-1]]
  end
end

def find_common_values(str)
  convert_string(str).map do |arr|
    arr[0].chars & arr[1].chars
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
