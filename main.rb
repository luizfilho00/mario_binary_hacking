require_relative 'hex.rb'

abort('usage: <rom> <table> <program>') if ARGV.length < 3

rom = ARGV[0]
table = ARGV[1]
program = ARGV[2]
ARGV.clear

$hex = HexEditor.new(rom, table)

def find
  print 'Buscar texto: '
  text = gets.chomp
  puts 'Valores hexadecimais encontrados: ' + $hex.search(text)
  puts 'Offset: ' + $hex.offset(text).to_s
end

case program
when 'finder'
  find
when 'extractor'
  puts 'call extractor'
when 'injector'
  puts 'call injector'
else
  puts 'programas: <finder> <extractor> <injector>'
end
