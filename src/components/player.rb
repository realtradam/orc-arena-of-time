FECS::Cmp.new('Player')
FECS::Cmp.new('Velocity', x: 0, y: 0)
FECS::Cmp.new('Position', x: 0, y: 0)
FECS::Cmp.new('Sprite',
              :texture,
              :origin,
              :source_rect,
              :dest_rect,
              :rotation)
FECS::Cmp.new('Hp', value: 0)

@player = FECS::Ent.new(FECS::Cmp::Player.new,
                        FECS::Cmp::Position.new,
                        FECS::Cmp::Velocity.new,
                        FECS::Cmp::Sprite.new(
                          texture: Rl::Texture.new('./assets/lancelot_.png'),
                          source_rect: Rl::Rectangle.new(0,0,24,24),
                          dest_rect: Rl::Rectangle.new(0,0,48,48)))



