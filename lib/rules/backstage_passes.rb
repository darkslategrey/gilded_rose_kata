class BackStagePasses < Rule
  def is_satisfied_by?(item)
    not /backstage passes/i.match(item.name).nil?
  end
end

class BackStagePassesSellInDaysLeftRangeIs < Rule
  @_lower
  @_upper

  def initialize(lower, upper)
    @_lower = lower
    @_upper = upper
  end

  def is_satisfied_by?(item)
    backstage_passes = BackStagePasses.new.is_satisfied_by?(item)
    backstage_passes and item.sell_in > @_lower and item.sell_in <= @_upper
  end
end

class BackStagePassesExpiredDays < Rule
  def is_satisfied_by?(item)
    backstage_passes = BackStagePasses.new.is_satisfied_by?(item)
    expired          = ExpiredDays.new.is_satisfied_by?(item)
    backstage_passes and expired
  end
end
