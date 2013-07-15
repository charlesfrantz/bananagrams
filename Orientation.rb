class Orientation
  attr_reader :directions

  def initialize(horiz = true)
    @directions = {
      forward: horiz ? :east : :south,
      backward: horiz ? :west : :north
    }
  end
end
