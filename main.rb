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

        user_input = gets.chomp
        if user_input.downcase == "quit" || user_input.downcase == "exit" #|| input == 4
            break
        elsif user_input == "1"
            showWeapons()
        end
    end
end

def showWeapons()
    i=0
    puts "Nasir: What do you need traveler?"
    puts "--- --- --- --- --- --- --- ---"
    while i<$weapons.length
        print $weapons[i][0]
        puts " [#{i+1}]"
        i += 1
    end
    puts "--- --- --- --- --- --- --- ---"

    user_input = gets.chomp
    isQuit(user_input)
    if user_input == "1"
        $money -= $weapons[0][2]
        $inventory << $weapons[0]
        p $inventory
    end

end

def isShop(user_input)
    if user_input.downcase != "yes"
        return false
    end
    return true
end

def fight!(enemy, health, weapon, armor)
    user_input = ""
    isQuit(user_input)
    puts "You are facing a #{enemy[0]}, what will you do?"
    puts "--- --- --- --- --- --- --- ---"
    puts "  Attack[1]  Eat[2]  Leave[3]"
    puts "--- --- --- --- --- --- --- ---"
    user_input = gets.chomp
    if user_input == "1" || user_input.downcase == "attack"
        puts "He ded."
        $money += enemy[4]
    end

    if user_input == "2" || user_input.downcase == "eat"
        writeLine("Homelander: Yummers.")
    end
end

def writeLine(string)
    temp = string+"\n"
    temp.each_char {|c| putc c ; sleep 0.01}
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
        writeLine("A #{enemy[0]} notices you!")
        writeLine("*The #{enemy[0]} shrieks!*")
        
        fight!(enemy, $health, $weapon, $armor)
        puts "Your money is #{$money}"
        user_input = gets.chomp
        isQuit(user_input)
    end
    
    user_input = ""
    writeLine("Do you want to shop?")
    user_input = gets.chomp
    isQuit(user_input)
    while isShop(user_input)
        shop!(user_input, $health, $weapon, $armor)
    end

end


main()