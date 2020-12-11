class Uclinter
  attr_accessor :err_check
  def initialize
    @err_check = ErrCheck.new(ARGV.first)
  end

  def my_linter
    err_check.trailing_spaces
    err_check.tag_error
    err_check.end_error
    err_check.empty_line_error

    if err_check.errors.empty? && err_check.file_checker.err_msg.empty?
      puts 'No offenses'.colorize(:green) + ' detected'
    else
      err_check.errors.uniq.each do |err|
        puts "#{err_check.file_checker.file_path.colorize(:blue)} : #{err.colorize(:red)}"
      end
    end

    puts err_check.file_checker.err_msg if err_check.file_checker.file_lines.empty?
  end
end
