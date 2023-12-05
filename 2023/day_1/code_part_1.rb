=begin
  The newly-improved calibration document consists of lines of text; each line originally contained a specific calibration value that the Elves now need to recover. On each line, the calibration value can be found by combining the first digit and the last digit (in that order) to form a single two-digit number.

  1abc2
  pqr3stu8vwx
  a1b2c3d4e5f
  treb7uchet

  In this example, the calibration values of these four lines are 12, 38, 15, and 77. Adding these together produces 142.
=end

=begin
  Breakdown
    - A line can contain multiple digits.
    - Combine the first and last digits on each line.
    - Repeat single digits

  Data structure
    - 1abc2 > First digit = '2', Second digit = '2', value = '1'.concat('2').to_i
    - Add this value to the total.
    -

  Problem
    - Iterate over each char from the start
    - Break when first digits is found
    - Iterate over each from the end
    - Break when second digit is found
    - Add all values and return the result

  Algorithm
    - To find first digit
      - Iterate from the start
      - Return the value at the current iteration if digit
    - To find second digit
      - Iterate from the end
      - Return the value at the current iteration if digit
    - Add the value formed by combining the digits to results array
    - Return the results array
=end

text = File.open('input.txt')

def find_total_value(text)
  text.split("\n").map do |string|
    first_number = find_first_digit(string)
    second_number = find_first_digit(string.reverse)

    first_number.concat(second_number).to_i
  end.sum
end

def find_first_digit(string)
  for n in string.chars
    return n if n.to_i.to_s == n
  end
end

p find_total_value(text.read)
text.close
