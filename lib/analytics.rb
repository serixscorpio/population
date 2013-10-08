require 'set'

class Analytics
  attr_reader :areas
  def initialize(areas)
    @areas = areas
  end

  def supported_queries
    [
      {index: 1, method: :number_of_zipcodes, name: 'Number of zipcodes'},
      {index: 2, method: :smallest_population, name: 'Smallest population (non 0)'},
      {index: 3, method: :largest_population, name: 'Largest population'},
      {index: 4, method: :number_of_zipcodes_in, name: 'How many zips in a state?', argument: {name: 'state', type: String}},
      {index: 5, method: :search_zipcode, name: 'Information for a given zip', argument: {name: 'zip', type: Integer}},
      {index: 6, method: :exit, name: 'Exit'}
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
