require 'csv'
require 'awesome_print'
require 'pry'

class Day
  attr_reader :year, :spec
  def initialize(year, spec: false)
    @spec = spec
    @year = year
  end

  private

  def file_path
    file_name = "#{self.class.name.slice(8..)}.txt"
    "#{year}/#{spec ? "spec/" : "/"}input/#{file_name}"
  end

  def data
    return @data if @data

    file = File.open(file_path)
    @data = case mode
    when :csv
      CSV.new(file).map(&:first)
    when :string
      file.read
    end
  end
end

