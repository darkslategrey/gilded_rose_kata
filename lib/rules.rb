$LOAD_PATH.unshift(File.dirname(__FILE__))

class Rule
  MIN_QUALITY = 0
  MAX_QUALITY = 50

  QUALITY_DECREMENT = 1
  QUALITY_DECREMENT_PASSED = QUALITY_DECREMENT * 2
  
  def is_satisfied_by?(item)
    raise 'must be implemented'
  end
end

class QualityUnderMin < Rule
  def is_satisfied_by?(item)
    item.quality < MIN_QUALITY
  end
end

class QualityOverMax < Rule
  def is_satisfied_by?(item)
    item.quality > MAX_QUALITY
  end
end

class ExpiredDays < Rule
  def is_satisfied_by?(item)
    item.sell_in <= 0
  end
end

require 'rules/aged_brie'
require 'rules/backstage_passes'
require 'rules/conjured'
require 'rules/sulfuras'
