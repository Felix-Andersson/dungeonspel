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
    while enemy_health > 0 && $health > 0
        displayPlayerStatus()
        user_input = ""
        writeLine "\nYou are facing a #{enemy[0]}, what will you do?"
        puts "--- --- --- --- --- --- --- ---"
        puts "Attack[1]  Eat[2]  Quit Game[3]"
        puts "--- --- --- --- --- --- --- ---"
        user_input = gets.chomp

        case user_input
        when "1"
            if $inventory[0][0] == "Violation"
                writeLine("You: #{$violations[rand(0..6)]}!")
            end
            enemy_health -= $inventory[0][1] + enemy[3] + rand(-5..5)                                         #Lägg till så att $weapon får damagen från items i inventory också
            writeLine("You attacked, dealing #{$inventory[0][1]} damage!")
        when "2"
            writeLine("Homelander: Yummers.")
            eat()
        when "quit", "exit", "3"
            puts ("Aight' have a good one, later! Ses imorgon! Ha de gött! hej!")
            exit(true)
        else
            raise "This wasn't supposed to be put in here!!"
        end

        #Enemy attack
        enemy_attack = enemy[2] - $inventory[1][1] + rand(-1..5)
        $health -= enemy_attack
        writeLine("#{enemy[0]} attacked, dealing #{enemy_attack} damage!")
        print "#{enemy[0]}'s Health: #{enemy_health}"
    end
    
    if enemy_health < 1
        puts "\nHe ded."
        $enemies_killed += 1
        $money += enemy[4]
        puts "Your money is #{$money}g" 
    else
        puts "\nWe ded."
        $money -= (0.2*$money)
        puts "Your money is #{$money}g" 
        #kanske förlorar ett random item från inventory eller något
    end

    writeLine("Enemies killed: #{$enemies_killed}")
end

def eat()
    writeLine("Which food would you like to consume?")
    i=0
    while i < $inventory[2].length
        print "#{i+1}. #{$inventory[2][i][0]}  "        #vad, vilket, namnet
        if (i % 3) == 0 && i != 0                               #sänker ner det en rad var 
            puts ""
        end
        i+=1
    end
    
    user_input = gets.chomp.to_i
    if user_input <= 0 && user_input > $inventory[2].length
        raise "This wasn't supposed to be put in here!!"
    end
    
    $health += $inventory[2][user_input][1]         #food, vilken, heatlht restored
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
        displayPlayerStatus()
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
        puts ("Aight' have a good one, later! Ses imorgon! Ha de gött! hej!")
        exit(true)                                          #stänger hela programmet
    end

    user_input = user_input.to_i

    if user_input <= 0 && user_input > $weapons.length
        raise "This wasn't supposed to be put in here!!"
    end
    if $money >= $weapons[user_input.to_i-1][2]
        writeLine("Bought #{$weapons[user_input.to_i-1][0]}")
        $inventory[0] = $weapons[user_input.to_i-1]         #Kan lägga till raise om användaren skriven in string
        $money -= $weapons[user_input.to_i-1][2]    
    else
        writeLine("Nasir: Get out you miserable pleb and stop wasting my time!")
    end
    
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
        puts ("Aight' have a good one, later! Ses imorgon! Ha de gött! hej!")
        exit(true)                                          #stänger hela programmet
    end

    user_input = user_input.to_i

    if user_input <= 0 && user_input > $armors.length
        raise "This wasn't supposed to be put in here!!"
    end
    if $money >= $armors[user_input.to_i-1][2] 
        writeLine("Bought #{$armors[user_input.to_i-1][0]}")
        $inventory[1] = $armors[user_input.to_i-1]         #Kan lägga till raise om användaren skriven in string
        $money -= $armors[user_input.to_i-1][2]    
    else
        writeLine("Nasir: Get out you miserable pleb and stop wasting my time!")
    end
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
        puts ("Aight' have a good one, later! Ses imorgon! Ha de gött! hej!")
        exit(true)                                          #stänger hela programmet
    end

    user_input = user_input.to_i

    if user_input <= 0 && user_input > $food.length
        raise "This wasn't supposed to be put in here!!"
    end
    if $money >= $food[user_input.to_i-1][2] 
        writeLine("Bought #{$food[user_input.to_i-1][0]}")
        $inventory << $food[user_input.to_i-1]
        $money -= $food[user_input.to_i-1][2]    
    else
        writeLine("Nasir: Get out you miserable pleb and stop wasting my time!")
    end
end

def writeLine(string)
    temp = string+"\n"
    temp.each_char {|c| putc c ; sleep 0.01}
end

def displayPlayerStatus()
    writeLine("\n")
    writeLine("Health: #{$health}")
    writeLine("Weapon: #{$inventory[0][0]}, Dmg: #{$inventory[0][1]}")
    writeLine("Armor: #{$inventory[1][0]}, Defence: #{$inventory[1][1]}")
    writeLine("Food: ")
    i=0
    while i < $inventory[2].length
        print "#{i+1}. #{$inventory[2][i][0]}  "        #vad, vilket, namnet
        if (i % 3) == 0 && i != 0                               #sänker ner det en rad var 
            puts ""
        end
        i+=1
    end
end
    
def main()
    user_input = ""
    writeLine("Ah we have finally found a teknikare, what is thou name?")
    name = gets.chomp
    while isQuit(user_input)
        writeLine("Saittam: I've heard that there is an impostor among us, stay alert!")
        writeLine("*Jakob comes running*")
        writeLine("Jakob: Big trouble up ahead, I spotted some monsters venting! Ses imorgon! Ha de gött! hej!")
        writeLine("Saittam: We must stop them, ahem, I mean you must stop them #{name}!\n")

        # Fight
        # Check if bosses
        if $enemies_killed == 10
            enemy = $bosses[rand($bosses.length)]
            writeLine("A towering #{enemy[0]} notices you!")
            writeLine("*The #{enemy[0]} roars with fury and the ground shakes.*")
        elsif $enemies_killed == 20
            enemy = $bosses[rand($bosses.length)]
            writeLine("A towering #{enemy[0]} notices you!")
            writeLine("*The #{enemy[0]} roars with fury and the ground shakes.*")
        elsif $enemies_killed == 30
            enemy = $bosses[rand($bosses.length)]
            writeLine("A towering #{enemy[0]} notices you!")
            writeLine("*The #{enemy[0]} roars with fury and the ground shakes.*")
        else
            enemy = $enemies[rand($enemies.length)]
            writeLine("A #{enemy[0]} notices you!")
            writeLine("*The #{enemy[0]} grunts.*")
        end
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