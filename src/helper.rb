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
