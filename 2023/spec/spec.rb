require_relative File.join(__dir__, '../../helpers/spec_helper.rb')

describe 'ADVENT OF CODE 2023' do

  EXPECTATIONS = {
    # '1' => [209, 281],
    '2' => [8, 2286],
  }

  EXPECTATIONS.each do |day, expected_result|
    include_examples 'Running tests...', 2023, day, expected_result, (day == EXPECTATIONS.keys.map(&:to_i).max.to_s)
  end
end
