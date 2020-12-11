require 'colorize'
require 'strscan'
require_relative 'readfile.rb'

class ErrCheck
  attr_accessor :file_checker, :errors

  def initialize(file_path)
    @trailing_msg = 'Error: Trailing whitespace detected.'
    @msg1 = 'Extra empty line detected at method body beginning'
    @msg2 = 'Use empty lines between method definition'
    @extra_empty_line_msg = 'Extra empty line detected at block body beginning'
    @class_emp_line = 'Extra empty line detected at class body beginning'
    @end_white_space = 'Extra empty line detected at block body end'

    @file_checker = FileRead.new(file_path)
    @errors = []
    @keywords = %w[begin case class def do if module unless]
  end

  def trailing_spaces
    @file_checker.file_lines.each_with_index do |str_val, index|
      if str_val[-2] == ' ' && !str_val.strip.empty?
        @errors.push("On line:#{index + 1}:#{str_val.size - 1}: #{@trailing_msg}")
        + " '#{str_val.gsub(/\s*$/, '_')}'"
      end
    end
  end

  def tag_error
    check_tag_error(/\(/, /\)/, '(', ')', 'Parenthesis')
    check_tag_error(/\[/, /\]/, '[', ']', 'Square Bracket')
    check_tag_error(/\{/, /\}/, '{', '}', 'Curly Bracket')
  end

  def end_error
    keyword_count = 0
    end_count = 0
    @file_checker.file_lines.each_with_index do |str_val, _index|
      keyword_count += 1 if @keywords.include?(str_val.split(' ').first) || str_val.split(' ').include?('do')
      end_count += 1 if str_val.strip == 'end'
    end

    status = keyword_count <=> end_count
    all_errors("Lint/Syntax: Missing 'end'") if status.eql?(1)
    all_errors("Lint/Syntax: Unexpected 'end'") if status.eql?(-1)
  end

  def empty_line_error
    @file_checker.file_lines.each_with_index do |valu, indx|
      end_white_space(valu, indx)
      check_def_empty_line(valu, indx)
      end_white_space(valu, indx)
      extra_empty_line(valu, indx)
    end
  end

  private

  def indent_error(str_val, indx, exp_val, msg)
    strip_line = str_val.strip.split(' ')
    emp = str_val.match(/^\s*\s*/)
    end_chk = emp[0].size.eql?(exp_val.zero? ? 0 : exp_val - 2)

    if str_val.strip.eql?('end') || strip_line.first == 'elsif' || strip_line.first == 'when'
      all_errors("line:#{indx + 1} #{msg}") unless end_chk
    elsif !emp[0].size.eql?(exp_val)
      all_errors("line:#{indx + 1} #{msg}")
    end
  end

  def check_tag_error(*args)
    @file_checker.file_lines.each_with_index do |str_val, index|
      open_p = []
      close_p = []
      open_p.push(str_val.scan(args[0]))
      close_p.push(str_val.scan(args[1]))

      status = open_p.flatten.size <=> close_p.flatten.size

      all_errors("line:#{index + 1} Lint/Syntax: Unexpected/Missing token '#{args[2]}' #{args[4]}") if status.eql?(1)
      all_errors("line:#{index + 1} Lint/Syntax: Unexpected/Missing token '#{args[3]}' #{args[4]}") if status.eql?(-1)
    end
  end

  def class_empty_line(str_val, indx)
    return unless str_val.strip.split(' ').first.eql?('class')

    all_errors("line:#{indx + 2} #{@class_emp_line}") if @file_checker.file_lines[indx + 1].strip.empty?
  end

  def check_def_empty_line(str_val, indx)
    return unless str_val.strip.split(' ').first.eql?('def')

    all_errors("line:#{indx + 2} #{@msg1}") if @file_checker.file_lines[indx + 1].strip.empty?
    all_errors("line:#{indx + 1} #{@msg2}") if @file_checker.file_lines[indx - 1].strip.split(' ').first.eql?('end')
  end

  def end_white_space(value, index)
    return unless value.strip.split(' ').first.eql?('end')

    all_errors("line:#{index} #{@end_white_space}") if @file_checker.file_lines[index - 1].strip.empty?
  end

  def extra_empty_line(valu, indx)
    return unless valu.strip.split(' ').include?('do')

    all_errors("line:#{indx + 2} #{@extra_empty_line_msg}") if @file_checker.file_lines[indx + 1].strip.empty?
  end

  def all_errors(error_msg)
    @errors.push(error_msg)
  end
end
