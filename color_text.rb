# color_text.rb här har vi två hjälpfunktioner och koder för stiliserandet av text. 
# Saittam = cyan
# Mattias = blue
# Attack = red
# Heal/food = green
# Narrator = bold
# inventory + money + food = italic

#Beskrivning: En samling färgkoder och stilkoder för stiliserandet av text. Helt inbyggd utan libraries. 

class String
    def black;          "\e[30m#{self}\e[0m" end
    def red;            "\e[31m#{self}\e[0m" end
    def green;          "\e[32m#{self}\e[0m" end
    def yellow;         "\e[33m#{self}\e[0m" end
    def blue;           "\e[34m#{self}\e[0m" end
    def magenta;        "\e[35m#{self}\e[0m" end
    def cyan;           "\e[36m#{self}\e[0m" end
    def gray;           "\e[37m#{self}\e[0m" end
    
    def bg_black;       "\e[40m#{self}\e[0m" end
    def bg_red;         "\e[41m#{self}\e[0m" end
    def bg_green;       "\e[42m#{self}\e[0m" end
    def bg_yellow;      "\e[43m#{self}\e[0m" end
    def bg_blue;        "\e[44m#{self}\e[0m" end
    def bg_magenta;     "\e[45m#{self}\e[0m" end
    def bg_cyan;        "\e[46m#{self}\e[0m" end
    def bg_gray;        "\e[47m#{self}\e[0m" end
    
    def bold;           "\e[1m#{self}\e[22m" end
    def italic;         "\e[3m#{self}\e[23m" end
    def underline;      "\e[4m#{self}\e[24m" end
    def blink;          "\e[5m#{self}\e[25m" end
    def reverse_color;  "\e[7m#{self}\e[27m" end
end

# Beskrivning:         Funktion som skriver ut text en karaktär i taget med mellanrum
# Argument 1:          String
# Exempel:      writeLine("abcd") -> a sleep(0.02) -> b sleep(0.02) etc. 

def writeLine(string)
    temp = string+"\n"
    temp.each_char {|c| putc c ; sleep 0.02}
end

# Beskrivning:         Funktion som skriver ut några blanka rader för att skapa mellanrum. Används i början av programmet för att #separera det från en tidigare körning. 
# Exempel:      

def clearConsole()
    puts "\e[H\e[2J"
end

#puts "I'm back green".yellow
#puts "I'm red and back cyan".red.bg_cyan
#puts "I'm bold and green and backround red".bold.green.bg_red
    