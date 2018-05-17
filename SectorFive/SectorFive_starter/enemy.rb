class Enemy
  SPEED = 4
  attr_reader :x, :y, :radius

  def initialize(window)
      @angle = 0  
      @facing_right_bottom = rand(0 - 2) #315
    if @facing_right_bottom < 1 then @angle += 45 
    else @angle += 315
    end    


    @radius = 20
    @x = rand(window.width - 2 * @radius) + @radius
    @y = 0
    @image = Gosu::Image.new('images/enemy.png') 
  end

  def draw
    @image.draw_rot(@x - @radius, @y - @radius, 1, @angle)
  end

  def move
    @y += SPEED
    @x -= Gosu.offset_x(@angle, SPEED)
  end

end
