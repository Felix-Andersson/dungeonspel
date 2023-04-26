# Player
$health = 100
$max_health = 100
$default_weapon = ["Rusty sword", 10, 0]
$default_armor = ["Half naked outfit", 1, 0]
$money = 0
$enemies_killed = 0
$bosses_killed = 0
#inventory  [weapons,armor,[food]]
$inventory = [$default_weapon,$default_armor,[$jarpar]]
$food_inventory = [$jarpar]

# Enemy stats    [name, health, weapon, armor, worth]
$goblin = ["Goblin", 30, 3, 3, 30]
$skeleton = ["Skeleton", 25, 6, 2, 30]
$microsoft_bengt = ["Microsoft Bengt", 35, 8, 0, 30]
$shaman = ["Shaman", 15, 10, 0, 30]

$enemies = [$goblin, $skeleton, $microsoft_bengt, $shaman]

# Boss stats     [name, health, weapon, armor, worth]
$troll = ["Troll", 800, 30, 13, 200]
$skeleton_king = ["Skeleton King", 700, 35, 3, 200]
$orc_lord = ["Orc Lord", 750, 40, 9, 200]
$mattias = ["Mattias", 5000, 25, 30, 1000000]

$bosses = [$troll, $skeleton_king, $orc_lord, $mattias]

# Shop items
#weapons    [name, damage, cost]
$electron_cannon = ["Electron Cannon", 200, 700]
$laser_pointer = ["Laser Pointer", 85, 300]
$violation = ["Violation", 15, 70]
$stick = ["Stick", 12, 30]
$spear = ["Spear", 25, 100]
$great_axe = ["Great Axe", 50, 200]
#mattias weapons, story weapons
$skarm = ["Skärm", 10000, 0]
$papper_penna = ["Papper och Penna", 100, 0]

$violations = ["Dumma dig", "Baen", "Bro finna regret", "No", "Yes", "Euugghh", "Ho Ho Ho"]

$weapons = [$electron_cannon, $laser_pointer, $violation, $stick, $spear, $great_axe]

#armor  [name, resistance, cost]
$nti_shirt = ["NTI Shirt", 12, 150]
$lader_dojor = ["Läder Dojor", 5, 85]
$kevlar = ["Kevlar", 20, 200]
$almost_naked_outfit = ["Almost naked outfit", 5, 30]

$armors = [$nti_shirt, $lader_dojor, $kevlar, $almost_naked_outfit]

#food   [name, health, cost]
$panerad_fisk = ["Panerad Fisk", 20, 30]
$meatball = ["Meatball", 15, 25]
$jarpar = ["Jarpar", 10, 15]
$knackebrod_frukost = ["Frukost knäckebröd", 50, 100]
$feferoni = ["Feferoni", 5, 10]

$food = [$panerad_fisk, $meatball, $jarpar, $knackebrod_frukost, $feferoni]