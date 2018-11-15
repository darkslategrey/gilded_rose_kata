class Sulfura < Rule
  def is_satisfied_by?(item)
    not /sulfuras/i.match(item.name).nil?
  end
end

class NotSulfuraExpiredDays < Rule
  def is_satisfied_by?(item)
    sulfra  = Sulfura.new.is_satisfied_by?(item)
    expired = ExpiredDays.new.is_satisfied_by?(item)
    not sulfra and expired
  end
end

class NotSulfuraNotExpiredDays < Rule
  def is_satisfied_by?(item)
    sulfra  = Sulfura.new.is_satisfied_by?(item)
    expired = ExpiredDays.new.is_satisfied_by?(item)
    not sulfra and not expired
  end
end
