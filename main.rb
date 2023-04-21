require_relative 'variables'

def isQuit(input)
    if input.downcase == "quit" || input.downcase == "exit" #|| input == 4
        return false
    end
    return true
end

# input loop
def shop!(user_input, health, armor, weapon)
    user_input = ""
    isQuit(user_input)
    while user_input != "leave"
        puts "Nasir: What do you need traveler?"
        puts "--- --- --- --- --- --- --- ---"
        puts "  Weapons[1]  Armor[2]  Food[3]"
        puts "--- --- --- --- --- --- --- ---"
    end
end

def fight!(enemy, health, weapon, armor)
    $user_input = ""
    isQuit($user_input)
    puts "You are facing a #{enemy}, what will you do?"
    puts "--- --- --- --- --- --- --- ---"
    puts "  Attack[1]  Eat[2]  Leave[3]"
    puts "--- --- --- --- --- --- --- ---"
    user_input = gets.chomp
    if user_input == "1" || user_input.downcase == "attack"
        puts "He ded."
    end
end

def writeLine(string)
    temp = string+"\n"
    temp.each_char {|c| putc c ; sleep 0.02}
end
    
def main()
    
    user_input = ""
    writeLine("Ah we have finally found a teknikare, what is thou name?")
    name = gets.chomp
    while isQuit(user_input)
        writeLine("Saittam: I've heard that there is an impostor among us, stay alert!")
        writeLine("*Jakob comes running*")
        writeLine("Jakob: Big trouble up ahead, I spotted some goblins vent!")
        writeLine("Saittam: We must stop them, ahem, I mean you must stop them #{name}!\n")
        enemy = $enemies[rand($enemies.length)]
        writeLine("A #{enemy} notices you!")
        writeLine("*The #{enemy} shrieks!*")
        
        fight!(enemy, $health, $weapon, $armor)
        user_input = gets.chomp
        isQuit(user_input)
    end
    

    

end


main()