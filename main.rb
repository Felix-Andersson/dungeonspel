# main.rb, vår main funktion och all gameplay-kod finns här. 
require_relative 'variables'
require_relative 'color_text'
require 'ruby2d' #gem install ruby2d

# Beskrivning:         Funktion som kollar om man vill quita...
# Argument 1:          String
# Return:              Returnerar false om string argumentet är lika med quit
#                      annars returnerar false
# Exempel:             if isQuit("quit") => false (går inte in i if-statmenten)

def isQuit(input)                               
    if input.downcase == "quit"
        return false
    end
    return true
end

# Beskrivning:         Funktion som kollar om man vill gå in i shop...
# Argument 1:          String
# Return:              Returnerar true om string argumentet är lika med yes
#                      annars returnerar false
# Gets:                user_input är en string som kan vara "yes" eller "no" eller vilken string som helst som inte är "yes"
# Exempel:             if isShop("yes") => true (går in i if-statmenten)

def isShop(user_input)
    if user_input.downcase == "yes"
        return true
    end
    return false
end

# Beskrivning:         Funktion som hanterar strider, fienden slumpas fram ur en tvådimensionell array. 
#                      Man har ett antal alternativ och resultatet för ett val har viss slumpmässighet. 
# Argument 1:          Array
# Gets:                user_input som kan vara antingen 1:fight, 2:eat, 3:blind eller 4:quit
# Return:              inget
# Exempel:             fight($goblin) -> $goblin=enemy

def fight(enemy)
    enemy_health = enemy[1]
    while enemy_health > 0 && $health > 0
        $blind_chance = 0
        displayPlayerStatus()
        user_input = ""
        writeLine("\nYou are facing a #{enemy[0]}, what will you do?".magenta)
        puts "--- --- --- --- --- --- --- --- --- --- ---"
        print "Attack[1]".bg_red.bold
        print "  "
        print "Eat[2]".bg_green.bold
        print "  "
        print "Blind (3 turns) [3]".bg_gray.bold
        print "  "
        print "Quit Game[4]".bg_blue.bold
        puts ""
        puts "--- --- --- --- --- --- --- --- --- --- ---"
        
        while ((user_input != "1") && (user_input != "2") && (user_input != "3") && (user_input != "4") && (user_input != "quit"))
            user_input = gets.chomp
            case user_input
            when "1"
                if enemy[0] != "Mattias"
                    $attack_sound.play
                else
                    $mattias_attacked_sound.play
                end
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
            when "3"
                if $blinded_turns > 0
                    writeLine("The enemy is already blinded".bold)
                    redo
                else
                    $blind_chance = rand(1..3)
                    if $blind_chance != 1
                        $blinded_turns = 3
                        if enemy[0] == "Mattias"
                            writeLine("Successfully took Mattias glasses")
                        else
                            writeLine("Successfully blinded enemy and avoided damage")
                        end
                        $blind_sound.play
                    else
                        writeLine("Failed to blind enemy!")
                    end
                end
            when "quit", "4"
                puts ("Aight' have a good one, later! Ses imorgon! Ha de gött! hej!")
                exit(true)
            when "info"
                print "Attack[1]".bg_red.bold
                puts ": deals damage to enemy based on weapon equiped"
                print "Eat[2]".bg_green.bold
                puts ": choose a food item from inventory to consume, restores health"
                print "Blind (3 turns) [3]".bg_gray.bold
                puts ": has a 2/3 chance of hitting, prevents enemy from dealing damage for 3 turns"
                print "Quit Game[4]".bg_blue.bold
                puts ": exits game"
            else
                puts "This wasn't supposed to be put in here!!"
            end
        end

        #Enemy attack
        if enemy_health > 0 && $blinded_turns <= 0
            enemy_attack = ((enemy[2] + rand(-1..5)) / $inventory[1][1])
            $health -= enemy_attack
            writeLine("#{enemy[0]} attacked, dealing #{enemy_attack} damage!".bg_red)
            writeLine("#{enemy[0]}'s Health: #{enemy_health}".bg_green)
        elsif $blinded_turns > 0
            writeLine("#{enemy[0]} attacked, but couldn't hit you because he was blinded. Truly unfortunate...")
            $blinded_turns -= 1
            writeLine("#{enemy[0]}'s Health: #{enemy_health}".bg_green)
            if $blinded_turns == 0
                writeLine("#{enemy[0]} isn't blinded anymore!")
            else
                writeLine("The #{enemy[0]} will be blinded for #{$blinded_turns} more turns")
            end
        end
    end
    
    if enemy_health < 1
        writeLine("\nThe #{enemy[0]} has fallen.".yellow.bold)
        $enemies_killed += 1
        $money += enemy[4]
        $blinded_turns = 0
        writeLine("Your money is #{$money}g".italic)
        if enemy[0] == "Troll" || enemy[0] == "Skeleton King" || enemy[0] == "Orc Lord"
            $bosses_killed += 1
            writeLine("You have defeated a boss monster!".bold)
        elsif enemy[0] == "Mattias"
            writeLine("Your money is #{$money}g".italic)
            $bosses_killed += 1
        end
    else
        if enemy[0] == "Mattias"
            $mattias_deaths += 1
        end
        writeLine("\nYour health ran out, and so did your wealth.".red)
        $money *= 0.8
        writeLine("Your money is #{$money}g".italic) 
        $dead = true
    end

    writeLine("Enemies killed: #{$enemies_killed}".italic)
end

# Beskrivning:         Funktion som skriver ut i terminalen alla element i en array. Dessa element kan
#                      väljas med en gets för att tas bort från arrayen.   
# Gets:                user_input som kan vara en integer mellan 1 och array.length
# Exempel:             eat() => 1. Jarpar    2. Köttbullar   3. Pannkaka
#                      user_input => 1
#                      arrayen har då kvar [$kottbullar, $pannkaka]

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

    $eat_sound.play
    $health += $food_inventory[user_input-1][1]     #vilken, health restored
    writeLine("You ate an item which restores #{$food_inventory[user_input-1][1]} health!".green)
    if $health > 100
        $health = 100
        writeLine("... but unfortunately you can't go beyond max health.")
    end
    $food_inventory.delete_at(user_input-1)

end

# Beskrivning:         Funktion som hanterar alla köp. Man kan köpa vapen, rustning och mat. Vapen och rustning ersätter de gamla men maten sparas på rad i ett inventory och tas bort när de konsumeras.   
# Gets:                user_input kan vara 1:weapons, 2:Armor, 3:Food och quit
# Exempel:             shop() -> user_input=1, -> user_input= 1 -> köp electron_cannon

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

# Beskrivning:         Funktion som visar vilka vapen man kan köpa...
# Argument 1:          Ingen
# Loop:                While-loop med hjälpfunktion - kollar om hjälpfunktionen är sann
# Return:              Ingen
#                      
# Exempel:             showWeapons()
#                      om isQuit(user_input) är true alltså om användaren inte har skrivit "quit" i terminalen
#                      writeline() funktionen körs samt kör puts med strängarna som står
#                      Går även in i if-satserna och kollar om dessa är sanna
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

# Beskrivning:         Funktion som visar vilken armor man kan köpa...
# Argument 1:          Ingen
#Loop:                 While-loop med hjälpfunktion - kollar om hjälpfunktionen är sann
# Return:              Ingen
#                      
# Exempel:             showArmors()
#                      om isQuit(user_input) är true alltså om användaren inte har skrivit "quit" i terminalen
#                      writeline() funktionen körs samt kör puts med strängarna som står
#                      Går även in i if-satserna och kollar om dessa är sanna

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

# Beskrivning:         Funktion som visar maten man har
# Argument 1:          Inget
# Loop:                 While-loop med hjälpfunktion - kollar om hjälpfunktionen är sann
# Return                Ingen      

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

# Beskrivning:         Funktion som skriver ut i terminalen variablerna health samt weapon och armor ur en 2-dimensionell array.
#                      Loopar även igenom food_inventory och printar varje element till terminalen.
# Exempel:             displayPlayerStatus() => 
#                      Health: 50/100
#                      Weapon: Svärd, Damage: 15
#                      Armor: Läderskor, Defence: 5
#                      Food: 1. Köttbullar  2. Pasta
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

# Beskrivning:         Main funktionen som inkluderar storyn i spelet genom att använda sig av hjälpfunktioner
# Argument 1:          ingen
# Hjälpfunktioner:     writeLine(), clearConsole(), isQuit(string), fight(array), displayPlayerStatus()
#                      isShop(string), shop(), eat()
# Loopar:              Använder isQuit while-loop för att se om användaren skrivit 'quit' i terminalen.
#                      Kollar om boss fighten är 
# Return:              inget
# Exempel:             main() => Går igenom hela spelet

def main()
    clearConsole() #Funktionen finns i color_text
    user_input = ""

    puts "Mål:".yellow
    puts "För att vinna spelet måste du besegra sista bossen, vilket kommer visa sig"
    puts "efter de 3 små bossarna. Under spelets gång kommer du att möta fiender och"
    puts "tjäna pengar, dessa pengar kan användas för att köpa vapen, armor och mat i shoppen.\n"

    puts "Instruktioner:".yellow
    puts "För att utföra handlingar så skrivs nummer (ex 1, 2, 3) i terminalen."
    puts "Om användaren vill backa ut ett steg i exempelvis shoppen så skrivs 'quit' i terminalen."
    puts "'quit' kan även användas för att avsluta programmet om det inte längre går att backa mer."
    puts "Använd 'info' i fight för att se vad de olika alternativen gör."
    puts "\nTryck på Enter för att gå vidare till spelet".green
    gets

    clearConsole()
    $leviathan_lagoon_song.play
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
            $health = 75
            $dead = false
            writeLine("Welcome back #{$name}! Are you okay?")
            writeLine("*Your health has been restored to #{$health}/100*".green)
        end
        if $bosses_killed >= 3
            if $mattias_deaths == 0
                $leviathan_lagoon_song.fadeout(2000)
                $japanlovania_song.play
                writeLine("*Jakob enters Saittam's room*".bold)
                sleep(0.4)
                writeLine("Saittam: Greetings Jakob, did you bring a pen and paper?".cyan)
                sleep(0.4)
                writeLine("Jakob: I actually brought something better!")
                sleep(0.4)
                writeLine("*Jakob takes out his computer*".bold)
                sleep(0.4)
                writeLine("Saittam: Y-you brought a computer?".cyan)
                sleep(0.4)
                writeLine("Jakob: Yes, it is much more efficient!")
                sleep(0.4)
                writeLine("*Saittam is standing in front of the whiteboard with a pen, sharpened to perfection*".bold)
                sleep(0.4)
                writeLine("Saittam: Aäeeh, skärmar i botten!".cyan)
                sleep(0.4)
                $skarmar2_sound.play
                writeLine("*Jakob looks att Saittam with a distraught expression*".bold)
                sleep(0.4)
                writeLine("Saittam: Inga digitala hjälpmedel! Penna o papper, det gäller samtliga!".cyan)
                sleep(0.4)
                writeLine("*Saittam throws the sharpened pen at a frightened Jakob*".bold)
                sleep(0.4)
                writeLine("Jakob is no more".bold)
                $skarmar_sound.volume = 80
                $skarmar_sound.play
                $skarmar2_sound.volume = 100
                $skarmar2_sound.play
                print "\nPress Enter to continue".green
                gets
                
                writeLine("*Jimmy comes running to you*")
                sleep(0.4)
                writeLine("Jimmy: #{$name}! #{$name}! Jakob is dead!")
                sleep(0.4)
                writeLine("#{$name}: What??")
                sleep(0.4)
                writeLine("Jimmy: I found him in Saittam's room!\n")
                sleep(0.4)
                
                writeLine("38 minutes later...\n".bold)
                sleep(1)
                
                writeLine("*You enter Saittam's room*".bold)
                sleep(0.4)
                writeLine("Saittam: #{$name} I take it Jakob has been destroyed. I must say you're sooner than expected.".cyan)
                sleep(0.4)
                writeLine("#{$name}: Saittam! Explain your actions. What did you do to Jakob? Are you really on our side?")
                $skarmar_sound.volume = 10
                $skarmar_sound.play
                sleep(0.4)
                writeLine("*Saittam gives you a furious glance and you realize your mistake*".bold)
                $skarmar_sound.volume = 50
                $skarmar_sound.play
                sleep(0.4)
                writeLine("Saittam: skärmar. Skärmar, SKÄRMAR I BOTTEN!".cyan)
                $skarmar_sound.volume = 80
                $skarmar_sound.play
                sleep(1)
                writeLine("*Saittam reveals himself to actually be Mattias\nand he throws his pen with full force at your skärm which is destroyed*".bold)
                sleep(0.4)
                writeLine("Mattias: PAPPER OCH PENNA! Inga digitala hjälpmedel".blue)
                $skarmar_sound.play
                $skarmar2_sound.play
                $skarmar2_sound.play
                sleep(0.4)
                writeLine("*You got the papper och penna weapon*".bold)
                $japanlovania_song.volume = 35
            elsif $mattias_deaths > 0
                writeLine("*You return from the grim reapers embrace and try once more to defeat this great menace.".bold)
                writeLine("Mattias: Hehehehe, ja tänkte att någon skulle skratta kanske".blue)
            end
            $inventory[0] = $papper_penna
            enemy = $bosses[3]
            fight(enemy)
        end

        if $bosses_killed == 4
            $mattias_defeated_sound.play
            writeLine("You managed to best the beast. But was this really it?".bold)
            writeLine("All this work, for some measly text?...".bold)
            writeLine("The answer? Yep, this is all you get. Have a look at your stats one last time or something.".bold)
            displayPlayerStatus()
            puts "\nPress Enter to continue".green
            gets
            clearConsole()
            writeLine("You won and secured the skärmar of the world!".yellow)
            writeLine("And you only died #{$mattias_deaths} to Mattias, gg wp!".yellow)
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