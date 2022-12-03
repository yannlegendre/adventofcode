require_relative File.join(__dir__, '../../helpers/spec_helper.rb')

describe 'ADVENT OF CODE 2021' do
  EXPECTATIONS = {
    '1' => [7, 5],
    '2' => [150, 900],
    '3' => [198, 230],
    '4' => [4512, 1924],
    '5' => [5, 12],
    '6' => [5934, 26984457539]
    }

  EXPECTATIONS.each do |day, expected_result|
    include_examples('Running tests...', 2021, day, expected_result, (day == EXPECTATIONS.keys.max))
  end
end