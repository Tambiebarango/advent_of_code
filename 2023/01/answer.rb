inputs = File.read('input.txt').split("\n")

# Part 1
answer = inputs.map do |i|
  fd = i.match(/[0-9]/)
  ld = i.reverse.match(/[0-9]/)
  "#{fd}#{ld}".to_i
end.sum

puts answer

# Part 2

map = { "one" => 1, "two" => 2, "three" => 3, "four" => 4, "five" => 5, "six" => 6, "seven" => 7, "eight" => 8, "nine" => 9 }
word_matches = map.keys.join("|")
answer = inputs.map do |i|
  matches = i.scan(/([0-9]|(?=(#{word_matches})))/)
             .flatten
             .compact
             .tap { |a| a.delete("") }
  fd = matches.first
  ld = matches.last
  fd = fd.match?(/[0-9]/) ? fd : map[fd]
  ld = ld.match?(/[0-9]/) ? ld : map[ld]
  "#{fd}#{ld}".to_i
end.sum

puts answer
