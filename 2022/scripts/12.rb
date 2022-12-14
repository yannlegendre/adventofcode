require_relative '../../helpers/day'

class Y2022Day12 < Day
  attr_accessor :start, :fin, :nodemap # "end" is reserved...
  POINT_CONST = 10_000

  def initialize(*args, **kwargs)
    super(*args, **kwargs)
    parse_input
  end

  def part1
    dijkstra(start, fin) => { prev:, dist: }
    shortest_path(prev, start, fin).count - 1
  end

  def part2
    dijkstra(fin, nil, part2: true)
  end

  private

  def parse_input
    @nodemap = data.split("\n").map { _1.chars}.map.with_index do |line, y|
      line.map.with_index do |letter, x|
        if letter == 'S'
          @start = { x: x, y: y }
          0
        elsif letter == 'E' then 0
          @fin = { x: x , y: y }
          25
        else
          letter.ord - 'a'.ord
        end
      end
    end
  end

  def id(x, y)
    (x + y * POINT_CONST).to_s
  end

  def cell(id)
    {
      x: id.to_i % POINT_CONST,
      y: id.to_i / POINT_CONST
    }
  end

  def dijkstra(source_node, destination_node, part2: false)
    dist = {}
    prev = {}
    queue = []
    nodemap.each_with_index do |line, y|
      line.each_with_index do |element, x|
        id = id(x, y)
        dist[id] = Float::INFINITY
        # prev[cell_to_number(x, y)] = nil
        queue << id
      end
    end

    dist[id(source_node[:x], source_node[:y])] = 0
    until queue.empty? do
      u = nil

      queue.each do |current|
        u = current if u.nil? || dist[current] < dist[u]
      end

      if part2
        cell = cell(u)
        return dist[u] if nodemap[cell[:y]][cell[:x]] == 0
      else
        break if u == id(destination_node[:x], destination_node[:y])
      end

      queue.delete(u)

      cell = cell(u)
      neighbors = neighbors(cell[:x], cell[:y], reverse: part2)

      neighbors.each do |v|
        if queue.include?(v)
          alt = dist[u] + 1
          if alt < dist[v]
            dist[v] = alt
            prev[v] = u
          end
        end
      end
    end

    {
      dist: dist,
      prev: prev
    }
  end

  def shortest_path(prev, source_node, destination_node)
    s = []
    u = id(destination_node[:x], destination_node[:y])
    source = id(source_node[:x], source_node[:y])
    if prev[u] || u == source
      until u.nil?
        s.unshift(u)
        u = prev[u]
      end
    end

    s
  end

  def neighbors(x, y, reverse: false)
    [].tap do |res|
      if y + 1 < nodemap.count
        condition = !reverse ? (nodemap[y+1][x] <= nodemap[y][x] + 1) : (nodemap[y+1][x] >= nodemap[y][x] - 1)
        res << id(x, y + 1) if condition
      end

      if y - 1 >= 0
        condition = !reverse ? (nodemap[y - 1][x] <= nodemap[y][x] + 1) : (nodemap[y - 1][x] >= nodemap[y][x] - 1)
        res << id(x, y - 1) if condition
      end

      if x + 1 < nodemap[y].count
        condition = !reverse ? (nodemap[y][x +1] <= nodemap[y][x] + 1) : (nodemap[y][x +1] >= nodemap[y][x] - 1)
        res << id(x + 1, y) if condition
      end

      if x - 1 >= 0
        condition = !reverse ? (nodemap[y][x - 1] <= nodemap[y][x] + 1) : (nodemap[y][x - 1] >= nodemap[y][x] - 1)
        res << id(x - 1, y) if condition
      end
    end
  end

  def mode
    :string
  end
end
