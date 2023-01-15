require 'yaml'

def format_array(str)
  base_array = str.split("\n")

  base_array.each do |i|
    i.delete! " "
  end
end

# A for rock
# B for paper
# C for scissors

# X for rock
# Y for paper
# Z for scissors

def decrypt(str)
  if str == 'A' || str == 'X'
    'rock' 
  elsif str == 'B' || str == 'Y'
    'paper'
  else
    'scissor'
  end
end

def win?(first, second)
  (first == 'rock' && second == 'scissor') ||
  (first == 'scissor' && second == 'paper') ||
  (first == 'paper' && second == 'rock')
end

# Score for single round:
# 1 for rock
# 2 for paper
# 3 for scissor

# 0 for loss
# 3 for draw
# 6 for win

def round_score(opponent, player)
  score = 0

  case player
  when 'X'
    score += 1
  when 'Y'
    score += 2
  when 'Z'
    score += 3
  end

  if win?(decrypt(player), decrypt(opponent))
    score += 6
  elsif win?(decrypt(opponent), decrypt(player))
    score += 0
  else
    score += 3
  end

  score
end

def total_score(str)
  array = format_array(str)
  total_score = []

  array.each do |i|
    total_score << round_score(i[0], i[1])
  end

  total_score.sum
end

string = YAML.load_file("day2_input.yml")

p total_score(string)
