#require_relative 'main'    det här kör hela main.rb vilket vi inte vill
require 'gosu'

class Player
    def initialize
        @image = Gosu::Image.new("images/brick.png")
        @x = @y = @vel_x = @vel_y = @angle = 0.0
    end
    
    def warp(x, y)
        @x, @y = x, y
    end
      
    def turn_left
        @angle -= 4.5
    end
      
    def turn_right
        @angle += 4.5
    end
      
    def accelerate
        @vel_x += Gosu.offset_x(@angle, 0.5)
        @vel_y += Gosu.offset_y(@angle, 0.5)
    end
      
    def move
        @x += @vel_x
        @y += @vel_y
        @x %= 1280      #resettar den när den går utanför skärmen
        @y %= 720       #resettar den när den går utanför skärmen
        
        @vel_x *= 0.95
        @vel_y *= 0.95
    end
    
    def draw
        @image.draw_rot(@x, @y, 2, @angle) #draw_rot målar bilden med x, y koordinaterna som mitten
    end
end

class GameWindow < Gosu::Window
    def initialize
        super(1280, 720, false) #width, height, fullscreen
        self.caption = "Impostor susy baka NTI finna regret"

        @background_image = Gosu::Image.new("images/brick.png", :tileable => true)
        @bg = Gosu::Image.new("images/bg.png", :tileable => true)

        @player = Player.new
        @player.warp(640, 410)
    end

    def update
        if (Gosu.button_down?(Gosu::KB_LEFT)) || (Gosu::button_down?(Gosu::GP_LEFT))
            @player.turn_left
        end
        if (Gosu.button_down?(Gosu::KB_RIGHT)) || (Gosu::button_down?(Gosu::GP_RIGHT))
            @player.turn_right
        end
        if (Gosu.button_down?(Gosu::KB_UP)) || (Gosu::button_down?(Gosu::GP_BUTTON_0))
            @player.accelerate
        end
        @player.move
    end

    def draw
        @background_image.draw(0,0,1)
        @background_image.draw(32,0,1)
        @background_image.draw(64,0,1)
        @background_image.draw(96,0,1)
        @background_image.draw(0,32,1)
        @background_image.draw(32,32,1)
        @background_image.draw(64,32,1)
        @background_image.draw(96,32,1)
        @bg.draw(0,0,0)

        @player.draw
    end

    def button_down(id)
        if id == Gosu::KB_ESCAPE
          close
        else
          super
        end
    end

end


GameWindow.new.show
