require_relative File.join(__dir__, '../../helpers/spec_helper.rb')

describe 'ADVENT OF CODE 2022' do
  res_10_2 = <<~RES
    ##..##..##..##..##..##..##..##..##..##..
    ###...###...###...###...###...###...###.
    ####....####....####....####....####....
    #####.....#####.....#####.....#####.....
    ######......######......######......####
    #######.......#######.......#######.....
  RES

  EXPECTATIONS = {
    '1' => [24000, 45000],
    '2' => [15, 12],
    '3' => [157, 70],
    '4' => [2, 4],
    '5' => ['CMZ', 'MCD'],
    '6' => [7, 19],
    '7' => [95437, 24933642],
    '8' => [21, 8],
    '9' => [13, 1],
    '10' => [13140, res_10_2.chomp],
    '11' => [10605, 2_713_310_158],
    '12' => [31, 29],
    '13' => [13, 140],
    '14' => [24, 93],
    '15' => [26, 56000011],
  }

  EXPECTATIONS.each do |day, expected_result|
    include_examples 'Running tests...', 2022, day, expected_result, (day == EXPECTATIONS.keys.map(&:to_i).max.to_s)
  end
end