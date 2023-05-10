require 'ruby2d'

set title: "Dungeon Spel?!"
set background: "random"
set resizable: true
set borderless: false
colorTriangle = Triangle.new(
    x1: 320, y1:  50,
    x2: 540, y2: 430,
    x3: 100, y3: 430,
    color: ['red', 'green', 'blue']
)
t = Triangle.new
t.x1 = 90
t.y3 = 25
t.color = 'red'
t.z = 1
t.color.opacity = 0.5
k = Triangle.new
k.color = 'navy'
#kan använda "hex decimal" samt [r,g,b,a] för att sätta färg
Quad.new(
  x1: 275, y1: 175,
  x2: 375, y2: 225,
  x3: 300, y3: 350,
  x4: 250, y4: 250,
  color: 'aqua',
  z: 0
)
Line.new(
  x1: 125, y1: 100,
  x2: 350, y2: 400,
  width: 20,
  color: 'lime',
  z: 20
)
Circle.new(
  x: 400, y: 175,
  radius: 50,
  sectors: 32,
  color: 'orange',
  opacity: 10
)
#Image.new(
#  'star.png',
#  x: 400, y: 200,
#  width: 50, height: 25,
# color: [1.0, 0.5, 0.2, 1.0],
#  rotate: 90,
#  z: 10
#)
#coin = Sprite.new(
#  'coin.png',
#  clip_width: 84, #hur bred varje bild i spritesheeten är
#  time: 300, #tid i millisekunder mellan varje frame
#  loop: true
#)
#coin.play

#boom = Sprite.new(
#  'boom.png',
#  clip_width: 127,
#  time: 75
#)
#boom.play do
#  puts "Animation finished!"   #visar detta efter animationen är färdig
#end

#hero = Sprite.new(
#  'hero.png',
#  width: 78,
#  height: 99,
#  clip_width: 78,
#  time: 250,
#  animations: {      #walk animationen är de två första framesen i spritesheeten
#    walk: 1..2,
#    climb: 3..4,
#    cheer: 5..6
#  }
#)

#on :key_down do |event|
#  case event.key
#    when 'left'
#      hero.play animation: :walk, loop: true, flip: :horizontal
#    when 'right'
#      hero.play animation: :walk, loop: true
#    when 'up'
#      hero.play animation: :climb, loop: true
#    when 'down'
#      hero.play animation: :climb, loop: true, flip: :vertical
#    when 'c'
#      hero.play animation: :cheer
#  end
#end


#atlas = Sprite.new(
#  'atlas.png',
#  animations: {
#    count: [
#      {
#        x: 0, y: 0,
#        width: 35, height: 41,
#        time: 300
#      },
#      {
#        x: 26, y: 46,
#        width: 35, height: 38,
#        time: 400
#      },
#      {
#        x: 65, y: 10,
#        width: 32, height: 41,
#        time: 500
#      },
#      {
#        x: 10, y: 99,
#        width: 32, height: 38,
#        time: 600
#      },
#      {
#        x: 74, y: 80,
#        width: 32, height: 38,
#        time: 700
#      }
#    ]
#  }
#)

#atlas.play animation: :count, loop: true
# ---------------------------------------------------- TILESETS
#tileset = Tileset.new(
#  'tileset.png',
#  tile_width: 84,
#  tile_height: 84,
#  padding: 1,      #pixlar från kanten av bilden
#  spacing: 2,      #pixlar mellan bilder
#  scale: 2         #scalar upp bilderna (default: 1)
#)

#tileset.define_tile('red', 0, 0, flip: :horizontal)
#tileset.define_tile('blue', 1, 0, flip: :vertical)
#tileset.define_tile('green', 0, 1, flip: :both)
#tileset.define_tile('purple', 1, 1, rotate: 90)

#tileset.set_tile('blue', [
#    { x: 0,  y: 0 },
#    { x: 84, y: 0 },
#    { x: 0,  y: 84 }
#])
#
#tileset.set_tile('red', [
#    { x: 84,  y: 84 }
#])
Text.new(
  'Hello',
  x: 450, y: 370,
  font: 'ELEPHNT.TTF',
  style: 'bold',
  size: 20,
  color: 'blue',
  rotate: 90,
  z: 10
)

#-----------------------------INPUT
#on :key do |event|
#  # All keyboard interaction
#  puts event
#end

#on :key_down do |event|
#  # A key was pressed
#  puts event.key
#end
# Byt ut :key_down mot...
# :key_up
# :key_held

#get :mouse_x     eller      Window.mouse_x
#get :mouse_y     eller      Window.mouse_y

#on :mouse do |event|
#  # A mouse event occurred
#  puts event
#end

#on :mouse_down do |event|
#  # x and y coordinates of the mouse button event
#  puts event.x, event.y
#
#  # Read the button event
#  case event.button
#  when :left
#    # Left mouse button pressed down
#  when :middle
#    # Middle mouse button pressed down
#  when :right
#    # Right mouse button pressed down
#  end
#end

#on :mouse_scroll do |event|
#  # Change in the x and y coordinates
#  puts event.delta_x
#  puts event.delta_y
#end

#on :mouse_move do |event|
#  # Change in the x and y coordinates
#  puts event.delta_x
#  puts event.delta_y
#
#  # Position of the mouse
#  puts event.x, event.y
#end

@square = Square.new(x: (Window.width/2)-10, y: (Window.height/2)-10, size: 20, color: 'red')

@x_speed = 0
@y_speed = 0

# Define what happens when a specific key is pressed.
# Each keypress influences on the  movement along the x and y axis.
on :key_down do |event|
  if event.key == 'j'
    @x_speed = -2
    @y_speed = 0
  elsif event.key == 'l'
    @x_speed = 2
    @y_speed = 0
  elsif event.key == 'i'
    @x_speed = 0
    @y_speed = -2
  elsif event.key == 'k'
    @x_speed = 0
    @y_speed = 2
  end
end

update do
  @square.x += @x_speed
  @square.y += @y_speed
end

show
#start_time = Time.now
#update do
#    #if (((Time.now-t).to_i % 2) == 0)
#    #    clear
#    #else 
#    #    colorTriangle.add
#    #end
#    #square.contains? 50, 50 #=> returnerar true om squaren är i pixlarna 50 50 annars false
#
#
#
#    # Close the window after 10 seconds
#    if Time.now - t > 10 then close end
#end