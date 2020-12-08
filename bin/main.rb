#!/usr/bin/env ruby
require_relative '../lib/check.rb'
class UcLinter
  attr_accessor :check
  def initialize
    @check = CheckError.new(ARGV.first)
  end
  
  def checker
    self.check.check_trailing_spaces
    self.check.tag_error
    self.check.end_error
    self.check.empty_line_error

    if check.errors.empty? && check.checker.err_msg.empty?
      puts 'No offenses'.colorize(:green) + ' detected '
    else
      check.errors.uniq.each do |err|
        puts "#{check.checker.file_path.colorize(:blue)} : #{err.colorize(:red)}"
      end
    end
    puts check.checker.err_msg if check.checker.file_lines.empty?
  end  
end

uclinter = UcLinter.new

uclinter.checker
