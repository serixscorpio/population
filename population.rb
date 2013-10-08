require_relative 'lib/analytics'
require_relative 'lib/csv_reader'
require_relative 'lib/setup'

class Population
  attr_reader :analytics
  def initialize(analytics)
    @analytics = analytics
  end

  def menu
    while true
      @analytics.supported_queries.each do |option|
        puts "#{option[:index]}. #{option[:name]}"  
      end
      print ": "
      choice = gets.chomp.to_i
      selected_option = @analytics.supported_queries.select do |option|
        choice == option[:index]
      end.first
      if selected_option[:method] == :exit
        break
      else
        argument_list = self.get_argument_list(selected_option[:argument])
        puts @analytics.send(selected_option[:method], *argument_list)
      end
    end
  end

  def get_argument_list(argument_option)
    [].tap do |argument_list|
      if argument_option
        print "#{argument_option[:name]}? "
        if argument_option[:type] == Integer
          argument_list << gets.chomp.to_i
        elsif argument_option[:type] == String
          argument_list << gets.chomp
        end
      end
    end
  end
end

Population.new(
  Analytics.new(Setup.new(CSVReader.new("free-zipcode-database.csv")).get_areas)).menu
  
