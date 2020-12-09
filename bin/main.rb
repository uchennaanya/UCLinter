#!/usr/bin/env ruby
require_relative '../lib/check.rb'
class UcLinter
  attr_accessor :check
  def initialize
    @check = CheckError.new(ARGV.first)
  end
  
  def checker
    check.trailing_spaces
    check.tag_error
    check.end_error
    check.empty_line_error

    if check.err.empty? && check.checker.err_msg.empty?
      puts 'No offenses'.colorize(:green) + ' detected '
    else
      check.err.uniq.each do |err|
        puts "#{check.checker.file_path.colorize(:blue)} : #{err.colorize(:red)}"
      end
    end
    puts check.checker.err_msg if check.checker.file_lines.empty?
  end  
end

uclinter = UcLinter.new

uclinter.checker
