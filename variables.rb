# Variables.rb, här har vi alla våra globala variabler
require 'ruby2d'

# Beskrivning: Ljud hanteras av librariet ruby2d.
# Sounds (max volym = 100)
$skarmar_sound = Sound.new('audio/Skarmar.wav')
$skarmar_sound.volume = 30
$skarmar2_sound = Sound.new('audio/Skarmar2.wav')
$skarmar2_sound.volume = 40
$mattias_attacked_sound = Sound.new('audio/mattias_attacked.wav')
$mattias_attacked_sound.volume = 40
$mattias_defeated_sound = Sound.new('audio/mattias_defeated.wav')
$leviathan_lagoon_song = Music.new('audio/leviathan_lagoon.mp3')
$leviathan_lagoon_song.volume = 50
$leviathan_lagoon_song.loop = true
$japanlovania_song = Music.new('audio/japanlovania.mp3')
$japanlovania_song.loop = true
$attack_sound = Sound.new('audio/Hit_Hurt76.wav')
$attack_sound.volume = 20
$enemy_hurt_sound = Sound.new('audio/enemy_hurt.wav')
$enemy_hurt_sound.volume = 5
$blind_sound = Sound.new('audio/blind_sound.mp3')
$eat_sound = Sound.new('audio/food_eating.wav')
$skarmar2_sound = Sound.new('audio/Skarmar2.wav')

# Enemy stats    [name, health, weapon, armor, worth]
$goblin = ["Goblin", 30, 3, 3, 30]
$skeleton = ["Skeleton", 25, 6, 2, 30]
$microsoft_bengt = ["Microsoft Bengt", 35, 8, 0, 30]
$shaman = ["Shaman", 15, 10, 0, 30]

$enemies = [$goblin, $skeleton, $microsoft_bengt, $shaman]

# Boss stats     [name, health, weapon, armor, worth]
$troll = ["Troll", 170, 18, 13, 100]
$skeleton_king = ["Skeleton King", 100, 20, 3, 100]
$orc_lord = ["Orc Lord", 150, 40, 9, 100]
$mattias = ["Mattias", 1300, 25, 30, 1000000]

$bosses = [$troll, $skeleton_king, $orc_lord, $mattias]

# Shop items
#weapons    [name, damage, cost]
$electron_cannon = ["Electron Cannon", 200, 450]
$laser_pointer = ["Laser Pointer", 70, 250]
$violation = ["Violation", 15, 70]
$stick = ["Stick", 12, 30]
$spear = ["Spear", 25, 150]
$great_axe = ["Great Axe", 50, 210]
#mattias weapons, story weapons
$skarm = ["Skärm", 10000, 0]
$papper_penna = ["Papper och Penna", 100, 0]

$violations = ["Dumma dig", "Baen", "Bro finna regret", "Ääeh sitt ner i båten", "Who asked??", "Euugghh", "Ho Ho Ho"]

$weapons = [$electron_cannon, $laser_pointer, $violation, $stick, $spear, $great_axe]

#armor  [name, resistance, cost] (1/3 av armor divideras bort från attacken)
$nti_shirt = ["NTI Shirt", 12, 150] #attack/4
$lader_dojor = ["Läder Dojor", 10, 110] #attack/3
$kevlar = ["Kevlar", 15, 250] #attack/5
$muddy_outfit = ["Muddy Outfit", 5, 30] #attack/2

$armors = [$nti_shirt, $lader_dojor, $kevlar, $muddy_outfit]

#food   [name, health, cost]
$panerad_fisk = ["Panerad Fisk", 20, 60]
$meatball = ["Meatball", 10, 30]
$jarpar = ["Jarpar", 69, 200]
$knackebrod_frukost = ["Frukost Knäckebröd", 25, 100]
$feferoni = ["Feferoni", 5, 10]

$food = [$panerad_fisk, $meatball, $jarpar, $knackebrod_frukost, $feferoni]

# Player
$name = ""
$health = 100
$max_health = 100
$default_weapon = ["Rusty Sword", 10, 0]
$default_armor = ["Half Naked Outfit", 1, 0] #attack/1
$money = 0
$enemies_killed = 0
$bosses_killed = 0 # testing value, should be 0
$mattias_deaths = 0
#inventory  [weapons,armor]
$inventory = [$default_weapon, $default_armor]
$food_inventory = [$jarpar] #börja med jarpar

$dead = false
$blind_chance = 0
$blinded_turns = 0