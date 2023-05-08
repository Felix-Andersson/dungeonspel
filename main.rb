require_relative 'variables'
require_relative 'color_text'
require 'ruby2d' #gem install ruby2d

def isQuit(input)
    if input.downcase == "quit"
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

    enemy_health = enemy[1]*$enemy_level_bonus
    while enemy_health > 0 && $health > 0
        displayPlayerStatus()
        user_input = ""
        writeLine("\nYou are facing a #{enemy[0]}, what will you do?".magenta)
        puts "--- --- --- --- --- --- --- ---"
        print "Attack[1]".bg_red.bold
        print "  "
        print "Eat[2]".bg_green.bold
        print "  "
        print "Quit Game[3]".bg_blue.bold
        puts ""
        puts "--- --- --- --- --- --- --- ---"
        
        while ((user_input != "1") && (user_input != "2") && (user_input != "3") && (user_input != "quit"))
            user_input = gets.chomp
            case user_input
            when "1"
                $attack_sound.play
                if $inventory[0][0] == "Violation"
                    writeLine("#{$name}: #{$violations[rand(0..6)]}!".blink.yellow)
                end
                attack_damage = $inventory[0][1] + enemy[3] + rand(-5..5)
                enemy_health -= attack_damage
                $enemy_hurt_sound.play                                         #Lägg till så att $weapon får damagen från items i inventory också
                writeLine("You attacked, dealing #{attack_damage} damage!".red)
            when "2"
                if $food_inventory.empty?
                    writeLine("You currently don't have any food in your inventory".bold)
                    redo
                else
                    eat()
                end
            when "quit", "3"
                puts ("Aight' have a good one, later! Ses imorgon! Ha de gött! hej!")
                exit(true)
            else
                puts "This wasn't supposed to be put in here!!"
            end
        end

        #Enemy attack
        if enemy_health > 0
            enemy_attack = (enemy[2] - $inventory[1][1] + rand(-1..5))*$enemy_level_bonus
            $health -= enemy_attack
            writeLine("#{enemy[0]} attacked, dealing #{enemy_attack} damage!".bg_red)
            writeLine("#{enemy[0]}'s Health: #{enemy_health}".bg_green)
        end
    end
    
    if enemy_health < 1
        writeLine("\nThe #{enemy[0]} has fallen.".yellow.bold)
        $enemies_killed += 1
        $money += enemy[4]
        writeLine("Your money is #{$money}g".italic)
        if enemy[0] == "Troll" || enemy[0] == "Skeleton King" || enemy[0] == "Orc Lord"
            $bosses_killed += 1
            $enemy_level_bonus += 0.2
            writeLine("You have defeated a boss monster!".bold)
            writeLine("The world level has risen, enemies will now have increased damage and health.".bold.red)
        end
    else
        writeLine("\nYour health ran out, and so did your wealth.".red)
        $money -= (0.2*$money)
        writeLine("Your money is #{$money}g".italic) 
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
        print "Attack[1]".bg_red.bold
        print "  "
        print "Eat[2]".bg_green.bold
        print "  "
        print "Quit Game[3]".bg_blue.bold
        puts ""
        puts "--- --- --- --- --- --- --- ---"

        while ((user_input != "1") && (user_input != "2") && (user_input != "3") && (user_input != "quit"))
            user_input = gets.chomp
            case user_input
            when "1"
                actions += 1
                attack_damage = $inventory[0][1] + mattias[3] + rand(-5..5)
                mattias_health -= attack_damage                                         #Lägg till så att $weapon får damagen från items i inventory också
                writeLine("You attacked, dealing #{attack_damage} damage!".red)
            when "2"
                actions += 1
                eat()
            when "quit", "3"
                puts ("Aight' have a good one, later! Ses imorgon! Ha de gött! hej!")
                exit(true)
            else
                puts "This wasn't supposed to be put in here!!"
            end
        end

        #Enemy attack
        if mattias_health > 0
            mattias_attack = mattias[2] - $inventory[1][1] + rand(-1..5)
            $health -= mattias_attack
            writeLine("#{mattias[0]} attacked, dealing #{mattias_attack} damage!".bg_red)
            print "#{mattias[0]}'s Health: #{mattias_health}"
        end
    end
    
    if enemy_health < 1
        writeLine("\nMattias is defeated. You are victorious.".yellow.bold)
        $enemies_killed += 1
        $money += mattias[4]
        writeLine("Your money is #{$money}g".italic)
        $bosses_killed += 1
    else
        writeLine("\nYour health ran out, and so did your wealth.".red.bold)
        $money -= (0.2*$money)
        writeLine("Your money is #{$money}g".italic)
        #kanske förlorar ett random item från inventory eller något
        $mattias_deaths += 1
        $dead = true
    end
end

def eat()
    writeLine("Which food would you like to consume?".bg_green.bold)
    i=0
    while i < $food_inventory.length
        print "#{i+1}. #{$food_inventory[i][0]}  ".italic        #vad, vilket, namnet
        if (i % 3) == 0 && i != 0                               #sänker ner det en rad var 
            puts ""
        end
        i+=1
    end
    
    user_input = gets.chomp.to_i
    while user_input <= 0 || user_input > $food_inventory.length
        puts "This wasn't supposed to be put in here!!"
        user_input = gets.chomp.to_i
    end
    
    $health += $food_inventory[user_input-1][1]     #vilken, health restored
    writeLine("You ate an item which restores #{$food_inventory[user_input-1][1]} health!".green)
    if $health > 100
        $health = 100
        writeLine("... but unfortunately you can't go beyond max health.")
    end
    $food_inventory.delete_at(user_input-1)

end

def shop()
    user_input = ""
    while isQuit(user_input)
        puts "\nNasir: What do you need traveler? ['quit' to exit the shop]".bold
        puts "--- --- --- --- --- --- --- ---"
        print " "
        print "Weapons[1]".bg_red.bold
        print "  "
        print "Armor[2]".bg_blue.bold
        print "  "
        print "Food[3]".bg_green.bold
        puts ""
        puts "--- --- --- --- --- --- --- ---"

        while user_input != "1" || user_input != "2" || user_input != "3" || user_input != "quit"
            user_input = gets.chomp
            case user_input
            when "1"     #switch-statement (annat sätt att skriva if-satser på typ)
                showWeapons()
                break
            when "2"
                showArmors()
                break
            when "3"
                showFood()
                break
            when "quit"
                break
            else
                puts "This wasn't supposed to be put in here!!"
            end
        end
        if user_input == "quit"
            break
        end

        #Visa inventory
        displayPlayerStatus()
    end
end

def showWeapons()
    user_input = ""
    while isQuit(user_input)
        i=0
        writeLine("Nasir: What do you need traveler? [current money: #{$money}]".bold)
        puts "--- --- --- --- --- --- --- ---"
        while i<$weapons.length
            puts "#{i+1}. +#{$weapons[i][1]} damage #{$weapons[i][0]}, #{$weapons[i][2]}g".red
            i += 1
        end
        puts "--- --- --- --- --- --- --- ---"

        user_input = gets.chomp

        while ((user_input.to_i <= 0 || user_input.to_i > $weapons.length) && user_input.downcase != "quit")
            puts "This wasn't supposed to be put in here!!"
            user_input = gets.chomp
        end

        if user_input.downcase == "quit"
            puts ("Aight' have a good one, later! Ses imorgon! Ha de gött! hej!")
            break
        end

        
        if $money >= $weapons[user_input.to_i-1][2]
            writeLine("Bought #{$weapons[user_input.to_i-1][0]}".italic)
            $inventory[0] = $weapons[user_input.to_i-1]
            $money -= $weapons[user_input.to_i-1][2]    
        else
            writeLine("Nasir: If you don't have enough money don't bother coming in the first place!")
        end
    end
end

def showArmors()
    user_input = ""
    while isQuit(user_input)
        i=0
        writeLine("Nasir: What do you need traveler? [current money: #{$money}]".bold)
        puts "--- --- --- --- --- --- --- ---"
        while i<$armors.length
            puts "#{i+1}. +#{$armors[i][1]} armor #{$armors[i][0]}, #{$armors[i][2]}g".blue
            i += 1
        end
        puts "--- --- --- --- --- --- --- ---"

        user_input = gets.chomp

        while ((user_input.to_i <= 0 || user_input.to_i > $armors.length) && user_input.downcase != "quit")
            puts "This wasn't supposed to be put in here!!"
            user_input = gets.chomp
        end

        if user_input.downcase == "quit"
            puts ("Aight' have a good one, later! Ses imorgon! Ha de gött! hej!")
            break
        end

        
        if $money >= $armors[user_input.to_i-1][2]
            writeLine("Bought #{$armors[user_input.to_i-1][0]}".italic)
            $inventory[1] = $armors[user_input.to_i-1]
            $money -= $armors[user_input.to_i-1][2]    
        else
            writeLine("Nasir: If you don't have enough money don't bother coming in the first place!")
        end
    end
end

def showFood()
    user_input = ""
    while isQuit(user_input)
        i=0
        writeLine("Nasir: What do you need traveler? [current money: #{$money}]".bold)
        puts "--- --- --- --- --- --- --- ---"
        while i<$food.length
            puts "#{i+1}. +#{$food[i][1]} health #{$food[i][0]}, #{$food[i][2]}g".green
            i += 1
        end
        puts "--- --- --- --- --- --- --- ---"

        user_input = gets.chomp

        while ((user_input.to_i <= 0 || user_input.to_i > $food.length) && user_input.downcase != "quit")
            puts "This wasn't supposed to be put in here!!"
            user_input = gets.chomp
        end

        if user_input.downcase == "quit"
            puts ("Aight' have a good one, later! Ses imorgon! Ha de gött! hej!")
            break
        end

        
        if $money >= $food[user_input.to_i-1][2]
            writeLine("Bought #{$food[user_input.to_i-1][0]}".italic)
            $food_inventory << $food[user_input.to_i-1]
            $money -= $food[user_input.to_i-1][2]    
        else
            writeLine("Nasir: If you don't have enough money don't bother coming in the first place!")
        end
    end
end

def displayPlayerStatus()
    writeLine("\nPlayer status:".bold)
    puts "Health: #{$health}/100".italic
    puts "Weapon: #{$inventory[0][0]}, Damage: #{$inventory[0][1]}".italic
    puts "Armor: #{$inventory[1][0]}, Defence: #{$inventory[1][1]}".italic
    print "Food: ".italic
    i=0
    while i < $food_inventory.length
        print "#{i+1}. #{$food_inventory[i][0]}  ".italic        #vad, vilket, namnet
        i+=1
    end
    puts ""
end

def startMusic()
    $leviathan_lagoon_song.volume = 50
    $leviathan_lagoon_song.loop = true
    $leviathan_lagoon_song.play
end

def main()
    clearConsole() #Funktionen finns i color_text
    user_input = ""

    puts "Instruktioner:".yellow
    puts "För att utföra handlingar så skrivs nummer (ex 1, 2, 3) i terminalen."
    puts "Om användaren vill backa ut ett steg i exempelvis shoppen så skrivs 'quit' i terminalen."
    puts "'quit' kan även användas för att avsluta programmet om det inte längre går att backa mer."
    puts "\nTryck på Enter för att gå vidare till spelet".green
    gets

    clearConsole()
    startMusic()
    writeLine("Ah we have finally found a teknikare, what is thou name?".bold)
    $name = gets.chomp.italic.blink
    writeLine("Alright then #{$name}, let us begin your adventure!".bold)

    writeLine("Saittam: I've heard that there is an impostor among us, stay alert!".cyan)
    $skarmar_sound.play
    writeLine("*Jakob comes running*".bold)
    writeLine("Jakob: Big trouble up ahead, I spotted some monsters venting! Ses imorgon! Ha de gött! hej!")
    writeLine("Saittam: We must stop them, ahem, I mean you must stop them #{$name}!\n".cyan)
    $skarmar_sound.play

    while isQuit(user_input)
        # Fight
        # Check if bosses
        if $dead
            $health = 50
            $dead = false
            writeLine("Welcome back #{$name}! Are you okay?")
        end
        if $bosses_killed == 3
            if $mattias_deaths == 0
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
                $skarmar_sound.play

                

                writeLine("*Jimmy comes running to you*")
                writeLine("Jimmy: #{$name}! #{$name}! Jakob is dead!")
                writeLine("#{$name}: What??")
                writeLine("Jimmy: I found him in Saittams room!")
                
                writeLine("38 minutes later...")
                
                writeLine("*You enter Saittam's room*")
                writeLine("Saittam: #{$name} I take it Jakob has been destroyed. I must say you're sooner than expected.")
                writeLine("#{$name}: Saittam! Explain your actions. What did you do to Jakob? Are you really on our side?")
                writeLine("*Saittam gives you a furious glance and you realize your mistake".bold)
                writeLine("Saittam: Skärmar. Skärmar, I BOTTEN!".cyan)
                $skarmar_sound.play
                $skarmar_sound.play
                $skarmar_sound.play
                writeLine("*Saittam reveals himself to actually be Mattias \n
                    and he throws his pen with full force at your skärm which is destroyed".bold)
                writeLine("Mattias: PAPPER OCH PENNA! Inga digitala hjälpmedel".blue)
                $skarmar_sound.play
                writeLine("You got the papper och penna weapon")
            elsif $mattias_deaths > 0
                writeLine("*You return from the grim reapers embrace and try once more to defeat this great menace.".bold)
                writeLine("Mattias: Hahahahahaha, hehehehehe, ja tänkte att någon skulle skratta kanske".blue)
            end
            $inventory[0] = $papper_penna
            enemy = $bosses[3]
            fight(enemy)
        end

        if $bosses_killed == 4
            clearConsole()
            writeLine("You won and secured the skärmar of the world!".yellow)
            $skarmar_sound.play
            writeLine("It is unfortunately time to say goodbye, but I wish you a merr- ...no, a wonderful evening.".yellow)
            writeLine("Ses imorgon! Ha de gött! hej!".yellow)
            gets
            exit(true)
        end
        
        if ($enemies_killed % 5) == 0 && $enemies_killed != 0 && $bosses_killed < 3
            enemy = $bosses[rand($bosses.length-1)]
            writeLine("\nA towering #{enemy[0]} meets your eyes!")
            writeLine("*The #{enemy[0]} roars with fury and the ground shakes*")
        elsif $bosses_killed < 3
            enemy = $enemies[rand($enemies.length)]
            writeLine("\nA #{enemy[0]} notices you!")
            writeLine("*The #{enemy[0]} grunts*")
        end
        if $bosses_killed < 3
            fight(enemy)
        end
        
        
        # Shop
        writeLine("Do you want to shop? [yes/no]".bold)
        user_input = gets.chomp
        if isShop(user_input)
            shop()
        end
        
        writeLine("Will you continue hunting monsters? [press Enter to continue / 'eat' to heal / 'quit' to exit game]".bold)
        user_input = gets.chomp
        if user_input.downcase == "eat"
            if $food_inventory.empty?
                writeLine("You currently don't have any food in your inventory".bold)
                writeLine("[press Enter to continue / 'quit' to exit game]")
                user_input = gets.chomp
            else
                eat()
            end
        end
    end
end


main()  #Kör programmet