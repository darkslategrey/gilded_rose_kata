class Conjured < Rule
  def is_satisfied_by?(item)
    not /conjured/i.match(item.name).nil?
  end
end

class ConjuredExpiredDays < Rule
  def is_satisfied_by?(item)
    conjured = Conjured.new.is_satisfied_by?(item)
    expired  = ExpiredDays.new.is_satisfied_by?(item)
    conjured and expired
  end
end

class ConjuredNotExpiredDays < Rule
  def is_satisfied_by?(item)
    conjured = Conjured.new.is_satisfied_by?(item)
    expired  = ExpiredDays.new.is_satisfied_by?(item)
    conjured and not expired
  end
end

