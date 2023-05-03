require_relative 'variables'
require_relative 'color_text'

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
        writeLine("\nYou are facing a #{enemy[0]}, what will you do?".magenta)
        puts "--- --- --- --- --- --- --- ---"
        print "Attack[1] ".bg_red.bold
        print " Eat[2] ".bg_green.bold
        puts "Quit Game[3]".bg_blue.bold
        puts "--- --- --- --- --- --- --- ---"
        user_input = gets.chomp

        case user_input
        when "1"
            if $inventory[0][0] == "Violation"
                writeLine("You: #{$violations[rand(0..6)]}!".blink.yellow)
            end
            enemy_health -= $inventory[0][1] + enemy[3] + rand(-5..5)                                         #Lägg till så att $weapon får damagen från items i inventory också
            writeLine("You attacked, dealing #{$inventory[0][1]} damage!".green)
        when "2"
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
        writeLine("#{enemy[0]} attacked, dealing #{enemy_attack} damage!".bg_red)
        print "#{enemy[0]}'s Health: #{enemy_health}"
    end
    
    if enemy_health < 1
        puts "\nHe ded."
        $enemies_killed += 1
        $money += enemy[4]
        puts "Your money is #{$money}g".italic
        if enemy[0] == "Troll" || enemy[0] == "Skeleton King" || enemy[0] == "Orc Lord"
            bosses_killed += 1
        end
    else
        puts "\nYou died.".red
        $money -= (0.2*$money)
        puts "Your money is #{$money}g".italic 
        #kanske förlorar ett random item från inventory eller något
        $dead = true
    end

    writeLine("Enemies killed: #{$enemies_killed}".italic)
end

def fightMattias(mattias)
    actions = 0
    mattias_health = mattias[1]
    while mattias_health > 0 && $health > 0
        displayPlayerStatus()
        user_input = ""
        writeLine("\nOh no, You are facing #{mattias[0]}, what will you do?".magenta)
        puts "--- --- --- --- --- --- --- ---"
        puts "Attack[1]  Eat[2]  Quit Game[3]".bold
        puts "--- --- --- --- --- --- --- ---"
        user_input = gets.chomp

        case user_input
        when "1"
            actions += 1
            if $inventory[0][0] == "Violation"
                writeLine("You: #{$violations[rand(0..6)]}!".blink)
            end
            mattias_health -= $inventory[0][1] + mattias[3] + rand(-5..5)                                         #Lägg till så att $weapon får damagen från items i inventory också
            writeLine("You attacked, dealing #{$inventory[0][1]} damage!".green)
        when "2"
            actions += 1
            eat()
        when "quit", "exit", "3"
            puts ("Aight' have a good one, later! Ses imorgon! Ha de gött! hej!")
            exit(true)
        else
            raise "This wasn't supposed to be put in here!!"
        end

        #Enemy attack
        mattias_attack = mattias[2] - $inventory[1][1] + rand(-1..5)
        $health -= mattias_attack
        writeLine("#{mattias[0]} attacked, dealing #{mattias_attack} damage!".red)
        print "#{mattias[0]}'s Health: #{mattias_health}"
    end
    
    if enemy_health < 1
        writeLine("\nMattias is defeated. You are victorious."-green.bold)
        $enemies_killed += 1
        $money += mattias[4]
        puts "Your money is #{$money}g".italic
        $bosses_killed += 1
    else
        writeLine("\nWe ded.".red.bold)
        $money -= (0.2*$money)
        puts "Your money is #{$money}g".italic 
        #kanske förlorar ett random item från inventory eller något
        mattias_deaths += 1
        $dead = true
    end
end

def eat()
    writeLine("Which food would you like to consume?".bold)
    i=0
    while i < $food_inventory.length
        print "#{i+1}. #{$food_inventory[i][0]}  "        #vad, vilket, namnet
        if (i % 3) == 0 && i != 0                               #sänker ner det en rad var 
            puts ""
        end
        i+=1
    end
    
    user_input = gets.chomp.to_i
    if user_input <= 0 && user_input > $food_inventory.length
        raise "This wasn't supposed to be put in here!!"
    end
    
    $health += $food_inventory[user_input-1][1]     #food, vilken, heatlht restored
    if $health > 100
        $health = 100
    end

end

def shop()
    user_input = ""
    while isQuit(user_input)
        puts "\nNasir: What do you need traveler?"
        puts "--- --- --- --- --- --- --- ---"
        puts " Weapons[1]  Armor[2]  Food[3] ".bold
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
        writeLine("Bought #{$weapons[user_input.to_i-1][0]}".italic)
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
        writeLine("Bought #{$armors[user_input.to_i-1][0]}".italic)
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
        writeLine("Bought #{$food[user_input.to_i-1][0]}".italic)
        $food_inventory << $food[user_input.to_i-1]
        $money -= $food[user_input.to_i-1][2]    
    else
        writeLine("Nasir: Get out you miserable pleb and stop wasting my time!")
    end
end

def displayPlayerStatus()
    writeLine("\n")
    writeLine("Health: #{$health}".italic)
    writeLine("Weapon: #{$inventory[0][0]}, Dmg: #{$inventory[0][1]}".italic)
    writeLine("Armor: #{$inventory[1][0]}, Defence: #{$inventory[1][1]}".italic)
    writeLine("Food: ")
    i=0
    while i < $food_inventory.length
        print "#{i+1}. #{$food_inventory[i][0]}  ".italic        #vad, vilket, namnet
        if (i % 3) == 0 && i != 0                               #sänker ner det en rad var 
            puts ""
        end
        i+=1
    end
end

def main()
    user_input = ""
    writeLine("Ah we have finally found a teknikare, what is thou name?".bold)
    name = gets.chomp.italic.blink
    while isQuit(user_input)
        if $enemies_killed == 0
        writeLine("Saittam: I've heard that there is an impostor among us, stay alert!".cyan)
        writeLine("*Jakob comes running*".bold)
        writeLine("Jakob: Big trouble up ahead, I spotted some monsters venting! Ses imorgon! Ha de gött! hej!")
        writeLine("Saittam: We must stop them, ahem, I mean you must stop them #{name}!\n".cyan)
        end
        # Fight
        # Check if bosses
        if $dead
            $health = 50
            $dead = false
            writeLine("Welcome back #{name}! Are you okay?")
        end
        if $bosses_killed == 3
            if mattias_deaths == 0
                writeLine("*Jakob enters Saittam's room*".bold)
                writeLine("Saittam: Greetings Jakob, did you bring a pen and paper?".cyan)
                writeLine("Jakob: I actually brought something better!")
                writeLine("*Jakob takes out his computer*".bold)
                writeLine("Saittam: Y-you brought a computer?".cyan)
                writeLine("Jakob: Yes, it is much more efficient!")
                writeLine("Saittam is standing in front of the whiteboard with a pen, sharpened to perfection.".cyan)
                writeLine("Saittam: Aäeeh, skärmar i botten!".cyan)
                writeLine("Jakob looks att Saittam with a distraught expression")
                writeLine("Saittam: Inga digitala hjälpmedel! Penna o papper det gäller samtliga!".cyan)
                writeLine("*Saittam throws the sharpened pen into the skull of a frightened Jakob*".bold)
                writeLine("Jakob is no more".bold)

                

                writeLine("*Jimmy comes running to you*")
                writeLine("Jimmy: #{name}! #{name}! Jakob is dead!")
                writeline("#{name}: What??")
                writeline("Jimmy: I found him in Saittams room!")
                
                writeLine("38 minutes later...")
                
                writeLine("*You enter Saittam's room*")
                writeLine("Saittam: #{name} I take it Jakob has been destroyed. I must say you're sooner than expected.")
                writeLine("#{name}: Saittam! Explain your actions. What did you do to Jakob? Are you really on our side?")
                writeLine("*Saittam gives you a furious glance and you realize your mistake".bold)
                writeLine("Saittam: Skärmar. Skärmar, I BOTTEN!".cyan)
                writeLine("*Saittam reveals himself to actually be Mattias \n
                    and he throws his pen with full force at your skärm which is destroyed".bold)
                writeLine("Mattias: PAPPER OCH PENNA! Inga digitala hjälpmedel".blue)
                writeLine("You got the papper och penna weapon")
            elsif mattias_deaths > 0
                writeLine("*You return from the grim reapers embrace and try once more to defeat this great menace.".bold)
                writeLine("Mattias: Hahahahahaha, hehehehehe, ja tänkte att någon skulle skratta kanske".blue)
            end
            $inventory[0] = $papper_penna
            enemy = $bosses[3]
            fight(enemy)
        end

        if $bosses_killed == 4
            writeLine("You won and secured the skärmar of the world!")
            isQuit("quit")
        end
        
        if $enemies_killed == 5 && $bosses_killed < 3
            enemy = $bosses[rand($bosses.length)]
            writeLine("A towering #{enemy[0]} notices you!")
            writeLine("*The #{enemy[0]} roars with fury and the ground shakes.*")
        elsif $enemies_killed == 15 && $bosses_killed < 3
            enemy = $bosses[rand($bosses.length)]
            writeLine("A towering #{enemy[0]} notices you!")
            writeLine("*The #{enemy[0]} roars with fury and the ground shakes.*")
        elsif $enemies_killed == 20 && $bosses_killed < 3
            enemy = $bosses[rand($bosses.length)]
            writeLine("A towering #{enemy[0]} notices you!")
            writeLine("*The #{enemy[0]} roars with fury and the ground shakes.*")
        elsif $bosses_killed < 3
            enemy = $enemies[rand($enemies.length)]
            writeLine("A #{enemy[0]} notices you!")
            writeLine("*The #{enemy[0]} grunts.*")
        end
        if $bosses_killed < 3
            fight(enemy)
        end
        
        
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