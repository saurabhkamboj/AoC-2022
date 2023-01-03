require 'yaml'

def result(str)
  base_array = str.split("\n\n")
  master_array = []

  for i in base_array
    master_array << i.split("\n")
  end

  top_three = totals(master_array).max(3)

  top_three.sum
end

def convert(array)
  for i in array
    i.map! { |str| str.to_i }
  end
end

def totals(array)
  totals_array = []

  for i in convert(array)
    totals_array << i.sum
  end

  totals_array
end

string = YAML.load_file("input.yml")

p result(string)
