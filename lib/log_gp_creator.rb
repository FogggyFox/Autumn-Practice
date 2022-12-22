#!/usr/bin/env ruby

def convert_row(row, logs)
  uuid = row.last
  new_row = row
  log_line = ''
  logs.each do |line|
    log_line = line unless line.match(uuid).nil?
  end
  return row if log_line == ''

  new = log_line.match(/email[=%]3?D?(.*) HTTP|phone%3D([0-9]*) /)
  if new[1].nil?
    new_row << 'phone'
    new_row << new[2]
  else
    new = new[1].gsub('%40', '@')
    new_row << 'email'
    new_row << new
  end
  new_row
end

GP_PATH = '../../gp'.freeze
LOG_PATH = '../../log'.freeze
RESULT_PATH = '../../result'.freeze
require 'csv'
f = File.new(LOG_PATH, 'r:UTF-8')
log_lines = f.readlines.uniq
f = File.new(RESULT_PATH, 'w:UTF-8')
result = CSV.new(f)
CSV.read(GP_PATH).each do |row|
  new_line = convert_row(row, log_lines)
  result << new_line
end

