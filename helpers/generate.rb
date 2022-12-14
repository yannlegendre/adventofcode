require 'fileutils'
require 'pry'
require 'net/http'
require 'dotenv'

Dotenv.load
year, day = ARGV

session_cookie = ENV['COOKIE']
uri = URI("https://adventofcode.com/#{year}/day/#{day}/input")

input = Net::HTTP.get(uri, { "Cookie" => "session=#{session_cookie}" })

def path(str)
  File.join(__dir__, str)
end

input_path = path("../#{year}/input/#{day}.txt")
spec_input_path = path("../#{year}/spec/input/#{day}.txt")
script_path = path("../#{year}/scripts/#{day}.rb")
template_path = path("template.rb")

input_file = File.open(input_path, 'w') do |file|
  file.write(input)
end

spec_input_file = File.open(spec_input_path, 'a')
spec_input_file.close
script_path = File.open(script_path, 'a')
FileUtils.cp(template_path, script_path)
script_path.close

