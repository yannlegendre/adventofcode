require_relative '../../helpers/day'

class Y2022Day7 < Day
  AVAILABLE_SPACE = 70_000_000
  REQUIRED_SPACE = 30_000_000

  attr_accessor :directories
  def initialize(*args, **kwargs)
    super(*args, **kwargs)

    @directories = { '/' => [] }
    parse_input
  end


  def part1
    folders_to_del = total_sums.select { |_, sum| sum < 100_000 }
    folders_to_del.values.sum
  end

  def part2
    used_space = total_sums['/']
    free_space = AVAILABLE_SPACE - used_space
    space_to_delete = REQUIRED_SPACE - free_space

    folders_eligible_for_deletion = total_sums.select do |path, size|
      size >= space_to_delete
    end

    min_size = folders_eligible_for_deletion.values.min
    folders_eligible_for_deletion.select { |_, size| size == min_size }.values.first
  end

  private

  def filtered_directories
    filtered_directories ||= directories.select do |path, _content|
      total_sum(path) <= 100_000
    end
  end

  def parse_input
    current_directory = '/'
    data.split("\n").each do |line|
      if is_command?(line)
        command, argument = line[2..].split(' ')

        case command
        when 'cd'
          current_directory =
            if argument == '..'
              dir = File.dirname(current_directory)
              if dir == '.'
                '/'
              else
                dir
              end
            else
              path = File.join(current_directory, argument)
              next unless directories.key?(path)

              path
            end
        end
      else
        size, name = line.split(' ')
        if size == 'dir'
          directories[File.join(current_directory, name)] = []
        else
          directories[current_directory] << size.to_i
        end
      end
    end
  end

  def is_command?(line)
    line.start_with?('$')
  end

  def total_sums
    @total_sums ||= directories.to_h do |path, content|
      [path, total_sum(path)]
    end
  end

  def total_sum(directory_path)
    directories.select do |path, _|
      path.start_with?(directory_path)
    end.sum do |path, content|
      content.sum
    end
  end

  def mode
    :string
  end
end

