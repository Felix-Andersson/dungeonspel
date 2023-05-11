require 'ruby2d'

set title: "Dungeon Spel?!"
set background: "#7bb59c"

@mouse_x_pos = 0
@mouse_y_pos = 0

@textBox = Rectangle.new(
    width: Window.width,
    height: 160,
    x: 0,
    y: (Window.height-160),
    color: "black"
)

@text = Text.new(
    "Ah we have finally found a teknikare, what is thou name?",
    x: 20,
    y: (Window.height-120),
    color: "white"
)
@input = Text.new(
    "",
    x: 20,
    y: (Window.height-100),
    color: "yellow"
)
name = ""
nameGotten = false

def 


# A key was pressed
on :key_down do |event|
    if nameGotten == false
        if event.key == "return"
            nameGotten = true
            @input.text = ""
            @text.text = "Alright then #{name}, let us begin your adventure!"
        elsif event.key == "backspace"
            name = name[0...-1]
            @input.text = name
        elsif "abcdefghijklmnopqrstuvwxyzåäö1234567890".include? event.key
            name += event.key
            name[0] = name[0].upcase
            @input.text = name
        end
    end
end

on :mouse_down do |event|
    if (event.button == :left) && (@textBox.contains? @mouse_x_pos, @mouse_y_pos)
        #pressed inside textbox
        
        @text.text = "Saittam: I've heard that there is an impostor among us, stay alert!"
    end

end

update do
    @mouse_x_pos = get :mouse_x
    @mouse_y_pos = get :mouse_y

end

show