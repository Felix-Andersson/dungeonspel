require 'ruby2d'

# Sounds (max volym = 100)
$skarmar_sound = Sound.new('audio/Skarmar.wav')
$skarmar_sound.volume = 30
$skarmar2_sound = Sound.new('audio/Skarmar2.wav')
$skarmar2_sound.volume = 40
$mattias_attacked_sound = Sound.new('audio/mattias_attacked.wav')
$mattias_attacked_sound.volume = 30
$mattias_defeated_sound = Sound.new('audio/mattias_defeated.wav')
$leviathan_lagoon_song = Music.new('audio/leviathan_lagoon.mp3')
$leviathan_lagoon_song.volume = 50
$leviathan_lagoon_song.loop = true
$japanlovania_song = Music.new('audio/japanlovania.mp3')
$japanlovania_song.volume = 10
$japanlovania_song.loop = true
$attack_sound = Sound.new('audio/Hit_Hurt76.wav')
$attack_sound.volume = 20
$enemy_hurt_sound = Sound.new('audio/enemy_hurt.wav')
$enemy_hurt_sound.volume = 5
$blind_sound = Sound.new('audio/blind_sound.mp3')
$eat_sound = Sound.new('audio/food_eating.wav')

# Enemy stats    [name, health, weapon, armor, worth]
$goblin = ["Goblin", 30, 3, 3, 30]
$skeleton = ["Skeleton", 25, 6, 2, 30]
$microsoft_bengt = ["Microsoft Bengt", 35, 8, 0, 30]
$shaman = ["Shaman", 15, 10, 0, 30]

$enemies = [$goblin, $skeleton, $microsoft_bengt, $shaman]

$enemy_level_bonus = 1

# Boss stats     [name, health, weapon, armor, worth]
$troll = ["Troll", 400, 18, 13, 200]
$skeleton_king = ["Skeleton King", 300, 20, 3, 200]
$orc_lord = ["Orc Lord", 525, 40, 9, 200]
$mattias = ["Mattias", 1000, 25, 30, 1000000]

$bosses = [$troll, $skeleton_king, $orc_lord, $mattias]

# Shop items
#weapons    [name, damage, cost]
$electron_cannon = ["Electron Cannon", 200, 400]
$laser_pointer = ["Laser Pointer", 70, 250]
$violation = ["Violation", 15, 70]
$stick = ["Stick", 12, 30]
$spear = ["Spear", 25, 100]
$great_axe = ["Great Axe", 50, 180]
#mattias weapons, story weapons
$skarm = ["Skärm", 10000, 0]
$papper_penna = ["Papper och Penna", 100, 0]

$violations = ["Dumma dig", "Baen", "Bro finna regret", "No", "Yes", "Euugghh", "Ho Ho Ho"]

$weapons = [$electron_cannon, $laser_pointer, $violation, $stick, $spear, $great_axe]

#armor  [name, resistance, cost]
$nti_shirt = ["NTI Shirt", 15, 80]
$lader_dojor = ["Läder Dojor", 8, 40]
$kevlar = ["Kevlar", 30, 150]
$almost_naked_outfit = ["Almost Naked Outfit", 5, 30]

$armors = [$nti_shirt, $lader_dojor, $kevlar, $almost_naked_outfit]

#food   [name, health, cost]
$panerad_fisk = ["Panerad Fisk", 20, 30]
$meatball = ["Meatball", 15, 25]
$jarpar = ["Jarpar", 10, 15]
$knackebrod_frukost = ["Frukost Knäckebröd", 50, 60]
$feferoni = ["Feferoni", 5, 10]

$food = [$panerad_fisk, $meatball, $jarpar, $knackebrod_frukost, $feferoni]

# Player
$name = ""
$health = 100
$max_health = 100
$default_weapon = ["Rusty Sword", 10, 0]
$default_armor = ["Half Naked Outfit", 1, 0]
$money = 0
$enemies_killed = 0
$bosses_killed = 3 # testing value, should be 0
$mattias_deaths = 0
#inventory  [weapons,armor]
$inventory = [$default_weapon, $default_armor]
$food_inventory = [$jarpar] #börja med jarpar

$dead = false
$blind_chance = 0
$blinded_turns = 0