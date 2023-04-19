#Huvudkaraktär
$health = 100
$armor = 0
$weapon = 3
$money = 0

#enemies
$enemies = ["Goblin", "Skeleton", "Microsoft Bengt", "Shaman"]
$bosses = ["Troll", "Skeleton King", "Orc lord"]
$ultimateBoss = "Mattias"

#enemy stats
$goblin_health = 40
$goblin_weapon = 1
$goblin_armor = 3
$goblin_worth = 30

$skeleton_health = 40
$skeleton_weapon = 3
$skeleton_armor = 0
$skeleton_worth = 30

$microsoftBengt_health = 60
$microsoftBengt_weapon = 5
$microsoftBengt_armor = 1
$microsoftBengt_worth = 30

$shaman_health = 30
$shaman_weapon = 6
$shaman_armor = 0
$shaman_worth = 30

#boss stats
$troll_health = 300
$troll_weapon = 9
$troll_armor = 13
$troll_worth = 100

$skeletonKing_health = 200
$skeletonKing_weapon = 15
$skeletonKing_armor = 3
$skeletonKing_worth = 100

$orcLord_health = 250
$orcLord_weapon = 12
$orcLord_armor = 9
$orcLord_worth = 100

# Mattias stats
$ultimateBoss_health = 1000
$ultimateBoss_weapon = 25
$ultimateBoss_armor = 30
$ultimateBossWorth = 1000000

# Shop items
$electron_canon = 100000
$laser_pointer = 500
$violation = 4
$stick = 6
$spear = 15
$great_axe = 25

$weapons = [$electron_canon, $laser_pointer, $violation, $stick, $spear, $great_axe]

$nti_shirt = 10
$boots = 5
$kevlar = 20

$armor = [$nti_shirt, $boots, $kevlar]

$panerad_fisk = 10
$meatball = 5
$jarpar = 6

$food = [$panerad_fisk, $meatball, $jarpar]

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
        puts "  Attack[1]  Eat[2]  Leave[3]"
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
    writeLine("Narrator: Ah we have finally found a teknikare, what is thou name?")
    name = gets.chomp
    while isQuit(user_input)
        writeLine("Mattias: I've heard that there is an impostor among us, stay alert!")
        writeLine("Narrator: Jakob comes running")
        writeLine("Jakob: Big trouble up ahead, I spotted some goblins vent!")
        writeLine("Mattias: We must stop them, ahem, I mean you must stop them #{name}!")
        enemy = $enemies[rand($enemies.length)]
        writeLine("A #{enemy} notices you!")
        writeLine("*The #{enemy} shrieks!*")
        
        fight!(enemy, $health, $weapon, $armor)
        user_input = gets.chomp
        isQuit(user_input)
    end
    

    

end


main()