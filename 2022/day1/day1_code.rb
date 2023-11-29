require 'yaml'

def result(str)
  base_array = str.split("\n\n")
  master_array = []

  for i in base_array
    master_array << i.split("\n")
  end

  top_three_totals = subarray_wise_total(master_array).max(3) # for solution of the first problem replace lines 11 and 13 with `subarray_wise_total(master_array).max`

  top_three_totals.sum
end

def convert_elements_to_integers(array)
  for i in array
    i.map! { |str| str.to_i }
  end
end

def subarray_wise_total(array)
  array_with_totals = []

  for i in convert_elements_to_integers(array)
    array_with_totals << i.sum
  end

  array_with_totals
end

string = YAML.load_file("day1_input.yml")

p result(string) # prints the sum of top 3 sub array's totals
