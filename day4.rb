#!/usr/bin/env ruby

fields = %w[byr iyr eyr hgt hcl ecl pid]
part1 = 0
part2 = 0

File.open('./day4_input.txt', 'r') do |file|
  found = []

  file.readlines.map(&:chomp).map do |line|
    if line.length.zero?
      part1 += 1 if fields & found == fields
      found = []
      next
    end

    found |= line.split.map { |p| p.split(':').first }
  end

  part1 += 1 if fields & found == fields
end

puts "Part 1: #{part1}"

def valid_year?(val, min, max)
  num = val.to_i
  num >= min && num <= max
end

def valid_regex?(val, regex)
  !regex.match(val).nil?
end

def valid_height?(val)
  return false unless valid_regex?(val, /^\d+(cm|in)$/)

  num = val[0...-2].to_i

  if val.end_with?('cm')
    num >= 150 && num <= 193
  else
    num >= 59 && num <= 76
  end
end

def valid?(record, fields)
  validations = record.map do |key, val|
    case key
    when 'byr' then valid_year?(val, 1920, 2002)
    when 'iyr' then valid_year?(val, 2010, 2020)
    when 'eyr' then valid_year?(val, 2020, 2030)
    when 'hgt' then valid_height?(val)
    when 'hcl' then valid_regex?(val, /^#[0-9a-f]{6}$/)
    when 'ecl' then valid_regex?(val, /^(amb|blu|brn|gry|grn|hzl|oth)$/)
    when 'pid' then valid_regex?(val, /^\d{9}$/)
    end
  end.filter { |i| i == true }

  validations.length == fields.length
end

File.open('./day4_input.txt', 'r') do |file|
  record = {}

  file.readlines.map(&:chomp).map do |line|
    if line.length.zero?
      part2 += 1 if valid?(record, fields)
      record = {}
      next
    end

    record.merge!(line.split.map { |p| p.split(':') }.to_h)
  end

  part2 += 1 if valid?(record, fields)
end

puts "Part 2: #{part2}"
