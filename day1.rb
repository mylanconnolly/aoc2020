#!/usr/bin/env ruby
# frozen_string_literal: true

input = []
part1 = []
part2 = []

File.open('./day1_input.txt', 'r') do |file|
  input = file.readlines.map(&:chomp).map(&:to_i).sort
end

input.each do |i1|
  input.each do |i2|
    sum1 = i1 + i2

    if sum1 == 2020
      part1 = [i1, i2].sort
    elsif sum1 < 2020
      input.each { |i3| part2 = [i1, i2, i3].sort if i1 + i2 + i3 == 2020 }
    end
  end
end

puts "Part 1: #{part1.reduce(:*)}"
puts "Part 2: #{part2.reduce(:*)}"
