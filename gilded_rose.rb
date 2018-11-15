$LOAD_PATH.unshift(File.dirname(__FILE__), 'lib')

require 'rules'

def update_quality(items)
  items.each do |item|

    ## quality stuff

    if(BackStagePassesSellInDaysLeftRangeIs.new(5, 10).is_satisfied_by?(item) \
       or AgedBrieExpiredDays.new.is_satisfied_by?(item))
      item.quality += 2
    elsif BackStagePassesSellInDaysLeftRangeIs.new(0, 5).is_satisfied_by?(item)
      item.quality += 3
    elsif BackStagePassesExpiredDays.new.is_satisfied_by?(item)
      item.quality = 0
    elsif(BackStagePasses.new.is_satisfied_by?(item) \
          or AgedBrieNotExpiredDays.new.is_satisfied_by?(item))
      item.quality += 1
    elsif ConjuredExpiredDays.new.is_satisfied_by?(item)
      item.quality -= Rule::QUALITY_DECREMENT_PASSED * 2
    elsif(ConjuredNotExpiredDays.new.is_satisfied_by?(item) \
          or NotSulfuraExpiredDays.new.is_satisfied_by?(item))
      item.quality -= Rule::QUALITY_DECREMENT * 2
    elsif NotSulfuraNotExpiredDays.new.is_satisfied_by?(item)
      item.quality -= Rule::QUALITY_DECREMENT
    end
    if QualityUnderMin.new.is_satisfied_by?(item)
      item.quality = Rule::MIN_QUALITY
    end
    if(QualityOverMax.new.is_satisfied_by?(item) \
       and not Sulfura.new.is_satisfied_by?(item))
      item.quality = Rule::MAX_QUALITY
    end

    ## sell_in stuff

    if(not Sulfura.new.is_satisfied_by?(item))
      item.sell_in -= 1
    end
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]
