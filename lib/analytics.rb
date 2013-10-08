require 'set'

class Analytics
  attr_reader :areas
  def initialize(areas)
    @areas = areas
  end

  def supported_queries
    [
      number_of_zipcodes: 'Number of zipcodes',
      smallest_population: 'Smallest population (non 0)',
      largest_population: 'Largest population',
      number_of_zipcodes_in: 'How many zips in a state?',
      search_zipcode: 'Information for a given zip'
    ]
  end 

  def number_of_zipcodes
    zipcode_set = Set.new
    @areas.each do |area|
      zipcode_set << area.zipcode
    end
    zipcode_set.size
  end

  def smallest_population
    populated_areas = @areas.select do |area|
      area.estimated_population > 0
    end
    populated_areas.min_by do |area|
      area.estimated_population
    end
  end

  def largest_population
    @areas.max_by do |area|
      area.estimated_population
    end
  end

  def number_of_zipcodes_in(state)
    @areas.count do |area|
      state == area.state
    end
  end

  def search_zipcode(zipcode)
    @areas.select do |area|
      zipcode == area.zipcode
    end
  end
end
