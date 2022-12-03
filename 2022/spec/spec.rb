require_relative File.join(__dir__, '../../helpers/spec_helper.rb')

describe 'ADVENT OF CODE 2022' do
  EXPECTATIONS = {
    '1' => [24000, 45000],
    '2' => [15, 12],
    '3' => [157, 70],
  }
  last_day_to_test = EXPECTATIONS.keys.max

  EXPECTATIONS.each do |day, expected_result|
    focus = day == last_day_to_test
    include_examples 'Running tests...', 2022, day, expected_result, focus
  end
end