require_relative File.join(__dir__, '../../helpers/spec_helper.rb')

describe 'ADVENT OF CODE 2022' do
  EXPECTATIONS = {
    '1' => [24000, 45000],
    '2' => [15, 12],
    '3' => [157, 70],
    '4' => [2, 4],
    '5' => ['CMZ', 'MCD'],
    '6' => [7, 19],
    '7' => [95437, 24933642],
  }

  EXPECTATIONS.each do |day, expected_result|
    include_examples 'Running tests...', 2022, day, expected_result, (day == EXPECTATIONS.keys.max)
  end
end