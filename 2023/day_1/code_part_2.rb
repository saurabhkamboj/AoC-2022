=begin
Your calculation isn't quite right. It looks like some of the digits are actually spelled out with letters: one, two, three, four, five, six, seven, eight, and nine also count as valid "digits".

Equipped with this new information, you now need to find the real first and last digit on each line. For example:

two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen

In this example, the calibration values are 29, 83, 13, 24, 42, 14, and 76. Adding these together produces 281.
=end

=begin
  Breakdown
    - A line can contain digits spelled in letters
    - Input: String
    - Output: Number

  Data structure
    - 7pqrstsixteen > First digit = 7
    - Second digit = 'six'
    - '7'.concat(digit_hash.key('six'))
    - 'sixty' > 0 to 2

  Algorithm
    - To find first digit
      - If digit is number then return number
      - Or iterate over each char
        - Collect all sub_groups
          - Return sub_group if digit_hash.key(value)
    - To find second digit
      - Iterate of array.reverse
        - If digit then return digit
      - Or iterate over each char of array
        - Collect sub_groups
          - Iterate over sub_groups.reverse
          - Return sub_group if digit_hash.key(value)
=end

HASH = %w(zero one two three four five six seven eight nine).zip('0'..'9').to_h

text = File.open('input.txt')

def find_total_value(text)
  text.split("\n").map do |string|
    digits = digits(string)

    (digits[0] + digits[-1]).to_i
  end.sum
end

def digits(string)
  select_valid_sub_strings(string.chars).map do |sub_string|
    HASH.key?(sub_string) ? HASH[sub_string] : sub_string
  end
end

def select_valid_sub_strings(array)
  sub_strings(array).select do |sub_string|
    HASH.key?(sub_string) || (sub_string.to_i.to_s == sub_string)
  end
end

def sub_strings(array)
  array.each_with_object([]).with_index do |(_, result), index|
    1.upto(array.length - index) do |length|
      result << array[index, length].join
    end
  end
end

p find_total_value(text.read)
text.close
