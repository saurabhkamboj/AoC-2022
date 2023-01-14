require 'yaml'

# A for rock
# B for paper
# C for scissors

WINS = [['A', 'C'], ['C', 'B'], ['B', 'A']]

def format_guide(str)
  base_arr = str.split("\n")

  base_arr.each do |i|
    i.delete! " "
  end
end

def find_player(opponent, outcome)
  player = ''

  if outcome == 'Z'
    WINS.each do |win| # player wins
      player = win[0] if win[1] == opponent
    end
  elsif outcome == 'X' # player loses
    WINS.each do |win|
      player = win[1] if win[0] == opponent
    end
  else
    player = opponent
  end

  player
end

# 1 for rock
# 2 for paper
# 3 for scissor

def round_score(opponent, outcome)
  player = find_player(opponent, outcome)
  score = 0

  case outcome
  when 'X'
    score += 0
  when 'Y'
    score += 3
  when 'Z'
    score += 6
  end

  case player
  when 'A'
    score += 1
  when 'B'
    score += 2
  when 'C'
    score += 3
  end

  score
end

def total_score(str)
  arr = format_guide(str)
  total_score = []

  arr.each do |i|
    total_score << round_score(i[0], i[1])
  end

  total_score.sum
end

string = YAML.load_file("day2_input.yml")

p total_score(string)
