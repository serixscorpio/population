require_relative 'area'

class Setup
  def initialize(csv_reader) 
    @csv_reader = csv_reader
  end

  def get_areas
    [].tap do |ary|
      @csv_reader.read do |row|
        ary << Area.new(row)
      end
    end
  end
end
