require 'gosu'

class Player < Gosu::Window
  
ROTATION_SPEED = 5
ACCELERATION = 2.5
FRICTION = 0.8
attr_reader :x, :y, :angle, :radius

  def initialize(window)
    @x =200
    @y = 200
    @angle = 0
    @image_ship = Gosu::Image.new('images/ship.png')
    @velocity_x = 0
    @velocity_y = 0
    @window= window
    @radius = 20
  end
  
  def draw
    @image_ship.draw_rot(@x, @y, 1, @angle)
  end

  def turn_right
    @angle += ROTATION_SPEED
  end
  
  def turn_left
    @angle -= ROTATION_SPEED
  end

  def accelerate
    @velocity_x += Gosu.offset_x(@angle, ACCELERATION)
    @velocity_y += Gosu.offset_y(@angle, ACCELERATION)
  end

  def move
  @x += @velocity_x
  @y += @velocity_y
  @velocity_x *= FRICTION
  @velocity_y *= FRICTION
  
    if @x > @window.width - @radius
        @velocity_x = 0
    end
    
    if @x < @radius
        @velocity_x = 0
        @x = @radius
    end
    if @y > @window.height - @radius
        @velocity_y = 0
        @y = @window.height - @radius
    end
    
  end


end
