# Player
$health = 100
$armor = 0
$weapon = 10
$money = 0
#inventory  [[weapons],[armor],[food]]
$inventory = [[],[],[]]

# Enemy stats    [name, health, weapon, armor, worth]
$goblin = ["Goblin", 10, 1, 3, 30]
$skeleton = ["Skeleton", 10, 3, 0, 30]
$microsoft_bengt = ["Microsoft Bengt", 20, 5, 1, 30]
$shaman = ["Shaman", 15, 6, 0, 30]

$enemies = [$goblin, $skeleton, $microsoft_bengt, $shaman]

# Boss stats     [name, health, weapon, armor, worth]
$troll = ["Troll", 300, 9, 13, 100]
$skeleton_king = ["Skeleton King", 200, 15, 3, 100]
$orc_lord = ["Orc Lord", 250, 12, 9, 100]
$mattias = ["Mattias", 1000, 25, 30, 1000000]

$bosses = [$troll, $skeleton_king, $orc_lord, $mattias]

# Shop items
#weapons    [name, damage, cost]
$electron_cannon = ["Electron Cannon", 100000, 100]
$laser_pointer = ["Laser Pointer", 500, 50]
$violation = ["Violation", 4, 30]
$stick = ["Stick", 6, 10]
$spear = ["Spear", 15, 40]
$great_axe = ["Great Axe", 25, 70]

$weapons = [$electron_cannon, $laser_pointer, $violation, $stick, $spear, $great_axe]

#armor  [name, resistance, cost]
$nti_shirt = ["NTI Shirt", 12, 400]
$lader_dojor = ["Läder Dojor", 5, 20]
$kevlar = ["Kevlar", 20, 50]

$armors = [$nti_shirt, $lader_dojor, $kevlar]

#food   [name, health, cost]
$panerad_fisk = ["Panerad Fisk", 10, 20]
$meatball = ["Meatball", 15, 30]
$jarpar = ["Jarpar", 5, 10]

$food = [$panerad_fisk, $meatball, $jarpar]