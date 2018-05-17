#--- Required Librairies ---#
require 'gosu'

#--- Begin | Class WhackARuby ---#
class WhackARuby < Gosu::Window

#--- Begin | Method initialize ---#
def initialize

    #--- Initializing | Window properties ---#    
    super(800, 600)                    #Window size
    self.caption = 'Whack the Ruby !'  #Window title

    #--- Initializing | Images ---#    
    @image = Gosu::Image.new('Images/ruby.png')            #Image of the Ruby
    @hammer_image = Gosu::Image.new('Images/hammer.png')   #Image of the Hammer
    
    @x = 200
    @y = 200
    
    @width = 50
    @height = 43
    
    @velocity_x = 4 #How much the image move each frame on the X axis
    @velocity_y = 4 #How much the image move each frame on the Y axis

    @visible = 0    #Is the Ruby visible ? (Positive number = Yes /Negative number = No )

    @hit = 0        #Did the player hit the Ruby ?
    
    @score = 0
    
    @font = Gosu::Font.new(30)
    
    @playing = true
    @start_time = 0
end
#--- End | Method initialize ---#

    
#--- Begin | Method update ---#
def update
    
    #--- Updating | Velocity ---#        
    
    @y += @velocity_y   #Move the image each frame on the Y axis
    @x += @velocity_x   #Move the image each frame on the X axis
 
    @velocity_x *= -1 if @x + @width / 2 > 800 || @x - @width / 2 < 0       #Check to see if the Ruby is going off screen on the X axis
    @velocity_y *= -1 if @y + @height / 2 > 600 || @y - @height / 2 < 0     #Check to see if the Ruby is going off screen on the Y axis

    @visible -= 1   #Each frame remove 1 to the value of visible
    @visible = 50 if @visible < -10 && rand < 0.05  #If @visible has been negative for 10 frames, there is a 0.05% chance that the Ruby appear

    @time_left = (30 - ((Gosu.milliseconds - @start_time) / 1000)) #Calculate the time left to play (30 seconds total)

    @playing = false if @time_left < 0
    
end
#--- End | Method update ---#

#--- Begin | Method button_down ---#
def button_down(id)
        if @playing
        if (id== Gosu::MsLeft)  #Check to see if the button pressed is the left one
            if Gosu.distance(mouse_x, mouse_y, @x, @y) < 50 && @visible >= 0    #Check to see if the center of the Ruby is at less than 50 pixels
                @hit = 1
                @score += 5
            else
                @hit = -1
                @score -=1
            end
        end
    end
clearelse
    if (id == Gosu::KbSpace)
        @playing =true
        @visible = -10
        @start_time = Gosu.milliseconds
        @score = 0
    end
end
    #--- End | Method button_down ---#
    
    #--- Begin | Method draw ---#
def draw
    
    if @visible > 0     #Draw the Ruby if @visible is a number bigger than 0
       @image.draw(@x - @width / 2, @y - @height / 2, 1)
    end
    
    @hammer_image.draw(mouse_x - 40, mouse_y - 10, 1)   #Draw the hammer on the mouse position
    
    if @hit == 0
        c = Gosu::Color::NONE
    elsif @hit == 1
        c = Gosu::Color::GREEN
    elsif @hit == -1
        c = Gosu::Color::RED
    end
    
    draw_quad(0, 0, c, 800, 0, c, 800, 600, c, 0, 600, c)
    @hit = 0

    @font.draw(@score.to_s, 700, 20, 2)

    @font.draw(@time_left.to_s, 20, 20, 2)

    unless @playing
        @font.draw('Game Over', 300, 300, 3)
        @font.draw('Press the spacebar to play again', 175, 350, 3)
        @visible = 20
    end
end
    #--- End | Method draw ---#

end
#--- End | Class WhackARuby ---#

window = WhackARuby.new     #Create the Window
window.show                 #Show the Window (also run the Method draw)
