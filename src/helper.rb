class Tileset
  attr_accessor :texture
  attr_writer :frames

  def initialize(*source_recs, texture:)
    source_recs.each do |rec|
      self.frames.push rec
    end

    self.texture = texture
  end

  def rec
    self.frames[self.frame.to_i]
  end

  def frame
    @frame ||= 0
  end

  def frame=(var)
    return @frame = 0 if frames.length.zero?
    @frame = (var % frames.length)
  end

  def step(amount = 1)
    self.frame += amount
  end

  def step_back(amount = 1)
    self.frame -= amount
  end

  def frames
    @frames ||= []
  end

end

module Helper
  class << self
    def decelerate(velocity_cmp, movement_cmp)
      velocity_mag = Math.sqrt((velocity_cmp.x**2) + (velocity_cmp.y**2))

      # If going slower then deceleration
      if velocity_mag <= (movement_cmp.deceleration * Rl.frame_time)
        # Set to 0
        velocity_cmp.x = 0
        velocity_cmp.y = 0
      else
        velocity_x_mag = velocity_cmp.x / velocity_mag
        velocity_y_mag = velocity_cmp.y / velocity_mag

        # Add deceleration
        velocity_cmp.x -= velocity_x_mag * movement_cmp.deceleration * Rl.frame_time
        velocity_cmp.y -= velocity_y_mag * movement_cmp.deceleration * Rl.frame_time
      end
      true
    end
  end
end
