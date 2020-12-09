require 'colorize'

class ReadFiles
  attr_accessor :err_msg, 
              :file_lines, 
              :file_path, 
              :file_lines_size
              
  def initialize(file_path)
    @err_msg = ''
    @file_path = file_path
    begin
      @file_lines = File.readlines(@file_path)
      @file_lines_size = @file_lines.size
    rescue StandardError => e
      @file_lines = []
      @err_msg = "Check file path again\n".colorize(:light_red) + e.to_s.colorize(:red)
    end
  end
end
