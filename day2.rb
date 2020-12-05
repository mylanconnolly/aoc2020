#!/usr/bin/env ruby

part1 = 0
part2 = 0

File.open('./day2_input.txt', 'r') do |file|
  file.readlines.map(&:chomp).map do |line|
    rules, password = line.split(': ')
    length, letter = rules.split
    lower, upper = length.split('-').map(&:to_i)
    found = password.length - password.delete(letter).length
    part1 += 1 if lower <= found && found <= upper
    part2 += 1 if (password[lower - 1] == letter) ^ (password[upper - 1] == letter)
  end
end

puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
