require ('colorize')

class FileReader
  attr_reader :err_msg, :file_lines, :file_path, :file_lines_size
  def initialize(file_path)
    @err_msg = ''
    @file_path = file_path
    begin
      @file_lines = File.readlines(@file_path)
      @file_lines_size = @file_lines.size
    rescue StandardError => e
      @file_lines = []
      @err_msg = "Check file name or path again\r".colorize(:light_red) + e.to_s.colorize(:red)
    end
  end
end
