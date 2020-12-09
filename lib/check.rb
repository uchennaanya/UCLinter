require 'colorize'
require 'strscan'
require_relative 'readfile.rb'

class ErrorCheckers
  attr_accessor :file_checker, :err

  def initialize(file_path)
    @file_checker = ReadFiles.new(file_path)
    @err = []
    @ruby_keywords = ["begin", "case", "class", "def", "do", "if", "module", "unless"]
  end

  def trailing_spaces
    @file_checker.file_lines.each_with_index do |v, i|
      if v[-2] == ' ' && !v.strip.empty?
        @err << "syntax error, line:#{i + 1}:#{v.size - 1}: Error: whitespace found."
        + " '#{v.gsub(/\s*$/, '_')}'"
      end
    end
  end

  def tag_error
    check_tag_error(/\(/, /\)/, '(', ')', 'Parenthesis')
    check_tag_error(/\[/, /\]/, '[', ']', 'Square Bracket')
    check_tag_error(/\{/, /\}/, '{', '}', 'Curly Bracket')
  end

  def end_error
    k_count = 0
    end_count = 0
    @file_checker.file_lines.each_with_index do |v, i|
      k_count += 1 if @ruby_keywords.include?(v.split(' ').first) || v.split(' ').include?('do')
      end_count += 1 if v.strip == 'end'
    end

    status = k_count <=> end_count
    log_error("Syntax error: missing 'end'") if status.eql?(1)
    log_error("Syntax error: unexpected 'end'") if status.eql?(-1)
  end

  def empty_line_er
    @file_checker.file_lines.each_with_index do |v, i|
      check_class_empty_line(v, i)
      check_def_empty_line(v, i)
      check_end_empty_line(v, i)
      check_do_empty_line(v, i)
    end
  end

  # rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

  private

  def indent_error(v, i, exp_val, info)
    strip_line = v.strip.split(' ')
    emp = v.match(/^\s*\s*/)
    end_chk = emp[0].size.eql?(exp_val.zero? ? 0 : exp_val - 2)

    if v.strip.eql?('end') || strip_line.first == 'elsif' || strip_line.first == 'when'
      log_error("line:#{i + 1} #{info}") unless end_chk
    elsif !emp[0].size.eql?(exp_val)
      log_error("line:#{i + 1} #{info}")
    end
  end

  # rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

  def check_tag_error(*args)
    @file_checker.file_lines.each_with_index do |v, i|
      open_p = []
      close_p = []
      open_p << v.scan(args[0])
      close_p << v.scan(args[1])

      status = open_p.flatten.size <=> close_p.flatten.size

      log_error("line:#{i + 1} Lint/Syntax: Unexpected/Missing token '#{args[2]}' #{args[4]}") if status.eql?(1)
      log_error("line:#{i + 1} Lint/Syntax: Unexpected/Missing token '#{args[3]}' #{args[4]}") if status.eql?(-1)
    end
  end

  def check_class_empty_line(v, i)
    info = 'Extra empty line detected at class body beginning'
    return unless v.strip.split(' ').first.eql?('class')

    log_error("line:#{i + 2} #{info}") if @file_checker.file_lines[i + 1].strip.empty?
  end

  def check_def_empty_line(v, i)
    info1 = 'empty line detected at method body beginning'
    info2 = 'Use empty lines between method definition'

    return unless v.strip.split(' ').first.eql?('def')

    log_error("line:#{i + 2} #{info1}") if @file_checker.file_lines[i + 1].strip.empty?
    log_error("line:#{i + 1} #{info2}") if @file_checker.file_lines[i - 1].strip.split(' ').first.eql?('end')
  end

  def check_end_empty_line(v, i)
    return unless v.strip.split(' ').first.eql?('end')

    log_error("line:#{i} Extra empty line detected at block body end") if @file_checker.file_lines[i - 1].strip.empty?
  end

  def check_do_empty_line(v, i)
    info = 'Extra empty line detected at block body beginning'
    return unless v.strip.split(' ').include?('do')

    log_error("line:#{i + 2} #{info}") if @file_checker.file_lines[i + 1].strip.empty?
  end

  def log_error(error_info)
    @err << error_info
  end
end
