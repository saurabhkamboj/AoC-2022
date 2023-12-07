class Range
  def intersect?(other)
    last >= other.first && first <= other.last
  end

  def intersection(other)
    return nil unless intersect?(other)

    [first, other.first].max..[last, other.last].min
  end

  def empty?
    size.zero?
  end

  def +(other)
    first + other..last + other
  end

  alias & intersection
end
