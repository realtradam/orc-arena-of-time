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

class Path
  def call(time)
    return nil unless self.paths[time.to_i]
    self.paths[time.to_i].call(time % 1)
  end

  def initialize(*paths)
    paths.each do |path|
      self.paths.push path
    end
  end

  def paths
    @paths ||= []
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

module Math
  class <<self
    # get a value in between two values
    # percent is represented by a decimal
    def interpolate(a, b, decimal_percent)
      ((b - a) * decimal_percent) + a
    end

    def midpoint(a, c)
      (a + c) / 2
    end

    def extend(a, b)
      (2 * b) - a
    end

    def bezier(points, time)
      result = 0
      points.each_with_index do |point, index|
        result += self.choose(points.length - 1.0, index) * ((1.0 - time) ** (points.length - 1.0 - index)) * (time ** index) * point
      end
      result
    end


    def choose(n, r)
      self.factorial(n).to_f / (self.factorial(r).to_f * self.factorial(n-r).to_f)
    end

    def factorial(f)
      if (@factorial ||= [1,1])[f].nil?
        @factorial[f] = f * factorial(f-1)
      else
        @factorial[f]
      end
    end

  end
end
