require 'csv'

class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
    gsub(/([a-z\d])([A-Z])/, '\1_\2').
    tr("-", "_").
    downcase
  end
end

CSV::HeaderConverters[:custom] = lambda do |raw_header|
  raw_header.gsub('"', '').underscore.to_sym
end

CSV::Converters[:custom] = lambda do |raw_field|
  raw_field && raw_field.gsub('"', '')
end

class CSVReader
  attr_reader :file_name
  def initialize(file_name)
    @file_name = file_name
  end

  def read
    CSV.foreach(@file_name, {headers: true, header_converters: :custom, converters: :custom}) do |row|
      yield row
    end
  end
end

