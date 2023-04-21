require_relative 'variables'

def isQuit(input)
    if input.downcase == "quit" || input.downcase == "exit" #|| input == 4
        return false
    end
    return true
end

def isShop(user_input)
    if user_input.downcase == "yes"
        return true
    end
    return false
end

def fight(enemy)
    enemy_health = enemy[1]
    while enemy_health > 0
        user_input = ""
        writeLine "\nYou are facing a #{enemy[0]}, what will you do?"
        puts "--- --- --- --- --- --- --- ---"
        puts "Attack[1]  Eat[2]  Quit Game[3]"
        puts "--- --- --- --- --- --- --- ---"
        user_input = gets.chomp

        case user_input
        when "1"
            writeLine("You attacked, dealing #{$weapon} damage!")
            enemy_health -= $weapon                                             #Lägg till så att $weapon får damagen från items i inventory också
            writeLine("The #{enemy[0]}'s health is at #{enemy_health}")
        when "2"
            writeLine("Homelander: Yummers.")
        when "quit", "exit", "3"
            puts ("Aight' have a good one, later!")
            exit(true)
        else
            raise "This wasn't supposed to be put in here!!"
        end
    end
    puts "He ded."
    $money += enemy[4]
    puts "Your money is #{$money}g"
end

def shop()
    user_input = ""
    while isQuit(user_input)
        puts "\nNasir: What do you need traveler?"
        puts "--- --- --- --- --- --- --- ---"
        puts " Weapons[1]  Armor[2]  Food[3] "
        puts "--- --- --- --- --- --- --- ---"

        user_input = gets.chomp
        case user_input
        when "1"     #switch-statement (annat sätt att skriva if-satser på typ)
            showWeapons()
        when "2"
            showArmors()
        when "3"
            showFood()
        when "quit", "exit"
            break
        else
            raise "This wasn't supposed to be put in here!!"
        end

        #Visa inventory
        showInventory()
    end
end

def showWeapons()
    i=0
    puts "Nasir: What do you need traveler? [current money: #{$money}]"
    puts "--- --- --- --- --- --- --- ---"
    while i<$weapons.length
        puts "+#{$weapons[i][1]} #{$weapons[i][0]} #{$weapons[i][2]}g, [#{i+1}]"
        i += 1
    end
    puts "--- --- --- --- --- --- --- ---"

    user_input = gets.chomp
    if user_input.downcase == "quit" || user_input.downcase == "exit"
        puts ("Aight' have a good one, later!")
        exit(true)                                          #stänger hela programmet
    end
    $inventory[0] << $weapons[user_input.to_i-1]         #Kan lägga till raise om användaren skriven in string
    $money -= $weapons[user_input.to_i-1][2]
end

def showArmors()
    i=0
    puts "Nasir: What do you need traveler? [current money: #{$money}]"
    puts "--- --- --- --- --- --- --- ---"
    while i<$armors.length
        puts "+#{$armors[i][1]} #{$armors[i][0]} #{$armors[i][2]}g, [#{i+1}]"
        i += 1
    end
    puts "--- --- --- --- --- --- --- ---"

    user_input = gets.chomp
    if user_input.downcase == "quit" || user_input.downcase == "exit"
        puts ("Aight' have a good one, later!")
        exit(true)                                          #stänger hela programmet
    end
    $inventory[1] << $armors[user_input.to_i-1]         #Kan lägga till raise om användaren skriven in string
    $money -= $armors[user_input.to_i-1][2]
end

def showFood()
    i=0
    puts "Nasir: What do you need traveler? [current money: #{$money}g]"
    puts "--- --- --- --- --- --- --- ---"
    while i<$food.length
        puts "+#{$food[i][1]} #{$food[i][0]} #{$food[i][2]}g, [#{i+1}]"
        i += 1
    end
    puts "--- --- --- --- --- --- --- ---"

    user_input = gets.chomp
    if user_input.downcase == "quit" || user_input.downcase == "exit"
        puts ("Aight' have a good one, later!")
        exit(true)                                          #stänger hela programmet
    end
    $inventory[2] << $food[user_input.to_i-1]         #Kan lägga till raise om användaren skriven in string
    $money -= $food[user_input.to_i-1][2]
end

def showInventory()
    print "Inventory:"
    i=0
    while i < $inventory.length
        puts "\n-"
        j=0
        while j < $inventory[i].length
            print "#{j+1}. #{$inventory[i][j][0]}  "
            j+=1
        end
        i+=1
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
        writeLine("Jakob: Big trouble up ahead, I spotted some monsters venting!")
        writeLine("Saittam: We must stop them, ahem, I mean you must stop them #{name}!\n")

        # Fight
        enemy = $enemies[rand($enemies.length)]
        writeLine("A #{enemy[0]} notices you!")
        writeLine("*The #{enemy[0]} grunts.*")
        fight(enemy)

        # Shop
        writeLine("Do you want to shop? [yes/no]")
        user_input = gets.chomp
        if isShop(user_input)
            shop()
        end

        writeLine("Finished shopping ey? Or maybe you didn't need anything. ['quit' to exit game]")
        user_input = gets.chomp
    end
end


main()  #Kör programmet