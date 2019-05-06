# Hexas precedidos de zeros são convertidos para tamanho 2 (OO, 1A, 2B)
def fix_hex_length(s)
  if (s.length < 2)
    ("0"+s).upcase
  else
    s.upcase
  end
end

# Hashmaps com código hexa e caracter -> "40" => "a"
table1 = Hash[File.read('table.tbl').split("\n").map { |i| i.split('=') }]
rom = File.read('SMario.sfc', mode: 'rb')

# Salva cada hexadecimal da ROM em um vetor
rom_dump = ""
rom.each_byte.map{ |b| rom_dump << fix_hex_length(b.to_s(16)) }

print 'Buscar texto: '
user_input = gets
# strip = remove /n /t espaços etc
user_input = user_input.strip

# Pega texto inserido pelo usuario e converte no valor hexa corresponde usando a tabela
txt_hexa = ""
user_input.each_char { |c| txt_hexa << table1.key(c) }
offset = rom_dump.index(txt_hexa) / 2

puts "Offset: " + offset.to_s
puts "Valores hexadecimais encontrados: " + txt_hexa.gsub(/(.{2})/, '\1 ').strip
