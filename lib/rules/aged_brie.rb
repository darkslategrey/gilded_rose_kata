class AgedBrie < Rule
  def is_satisfied_by?(item)
    not /aged brie/i.match(item.name).nil?
  end
end

class AgedBrieExpiredDays < Rule
  def is_satisfied_by?(item)
    aged    = AgedBrie.new.is_satisfied_by?(item)
    expired = ExpiredDays.new.is_satisfied_by?(item)
    aged and expired
  end
end

class AgedBrieNotExpiredDays < Rule
  def is_satisfied_by?(item)
    aged    = AgedBrie.new.is_satisfied_by?(item)
    expired = ExpiredDays.new.is_satisfied_by?(item)
    aged and not expired
  end
end
