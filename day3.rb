#!/usr/bin/env ruby

part1 = 0
ratios = [1.to_f, 1 / 3.to_f, 1 / 5.to_f, 1 / 7.to_f, 2 / 1.to_f]
part2 = ratios.map { 0 }
offset = 0

File.open('./day3_input.txt', 'r') do |file|
  file.readlines.map(&:chomp).map do |line|
    part1 += 1 if line[offset % line.length] == '#'
    offset += 3
  end
end

puts "Part 1: #{part1}"

ratios.each_with_index do |ratio, i|
  File.open('./day3_input.txt', 'r') do |file|
    offset = 0

    file.readlines.map(&:chomp).each_with_index do |line, j|
      x = 1 / ratio
      offset = x * j
      next unless (offset % 1).zero?

      part2[i] += 1 if line[offset % line.length] == '#'
    end
  end
end

puts "Part 2: #{part2.inspect} = #{part2.reduce(:*)}"
