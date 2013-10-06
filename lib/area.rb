class Area
  attr_accessor :zipcode, :estimated_population, :city, :state
  def initialize(csv_row)
    @zipcode = csv_row[:zipcode] || "n/a"
    @estimated_population = csv_row[:estimated_population] || 0
    @city = csv_row[:city] || "n/a"
    @state = csv_row[:state] || "n/a"
  end

  def to_s
    "#{@city}, #{@state} #{@zipcode} has #{@estimated_population} people."
  end
end
