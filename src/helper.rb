# different states
# each state has a set of frames
# each state remembers what frame it was set it
# each frame has a rectangle for rendering, and a rectangle for a hitbox
class Tileset
  attr_accessor :texture
  attr_writer :frames

  def initialize(*source_rects, texture:)
    source_rects.each do |rect|
      self.frames.push rect
    end

    self.texture = texture
  end

  def rect
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
