require 'csv'
require 'awesome_print'
require 'pry'

class Day
  attr_reader :spec
  def initialize(spec: false)
    @spec = spec
  end

  private
  def self.year
    name.slice(1..4).to_i
  end

  def file_path
    file_name = "#{self.class.name.slice(8..)}.txt"
    "#{self.class.year}/#{spec ? "spec/" : "/"}input/#{file_name}"
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

