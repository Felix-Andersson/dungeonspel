#player
$health = 100
$armor = 0
$weapon = 3
$money = 0

#enemies
$bosses = ["Troll", "Skeleton King", "Orc lord"]
$ultimateBoss = "Mattias"

#enemy stats    [name, health, weapon, armor, worth]
$goblin = ["Goblin", 40, 1, 3, 30]

$skeleton = ["Skeleton", 40, 3, 0, 30]

$microsoftBengt = ["Microsoft Bengt", 60, 5, 1, 30]

$shaman = ["Shaman", 30, 6, 0, 30]

$enemies = [$goblin, $skeleton, $microsoftBengt, $shaman]

#boss stats     [health, weapon, armor, worth]
$troll = [300, 9, 13, 100]

$skeleton = [200, 15, 3, 100]

$orcLord = [250, 12, 9, 100]

$mattias = [1000, 25, 30, 1000000]

# Shop items
#weapons    [name, damage, cost]
$electron_cannon = ["Electron cannon", 100000]
$laser_pointer = ["Laser pointer", 500]
$violation = ["Violation", 4]
$stick = ["Stick", 6]
$spear = ["Spear", 15]
$great_axe = ["Great axe", 25]

$weapons = [$electron_cannon, $laser_pointer, $violation, $stick, $spear, $great_axe]

#armor
$nti_shirt = 10
$boots = 5
$kevlar = 20

$armor = [$nti_shirt, $boots, $kevlar]

#food
$panerad_fisk = 10
$meatball = 5
$jarpar = 6

$food = [$panerad_fisk, $meatball, $jarpar]

#inventory
$inventory = []