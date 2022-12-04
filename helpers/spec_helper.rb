require 'rspec'
path = File.join(__dir__, '../*/scripts', '*.rb')
Dir[path].each { require_relative _1 }

shared_examples 'Running tests...' do |year, day, expected_result, focus|
  it "#{day} works", focus: focus do
    klass = Object.const_get("Y#{year}Day#{day}")
    expect(klass.new(spec: true).part1).to eq expected_result.first
    expect(klass.new(spec: true).part2).to eq expected_result.last

    puts klass.name.slice(5..)
    puts "Part 1: #{klass.new.part1}"
    puts "Part 2: #{klass.new.part2}"
    puts
  end
end