table1 = Hash[File.read('table.tbl').split("\n").map { |i| i.split('=') }].invert
table2 = Hash[File.read('table2.tbl').split("\n").map { |i| i.split('=') }].invert
rom = File.read('SMario.sfc', mode: 'rb')

# Converte strings para seu valor hexadecimal
def bin_to_hex(s)
  s.each_byte.map { |b| b.to_s(16) }.join(' ')
end

# Converte valor hexadecimal para decimal
def hex_to_bin(s)
    s.scan(/../).map { |x| x.hex.chr }.join
end

# imprime arquivo como hexadecimal
puts bin_to_hex(rom)

print 'Busque um texto: '
txt = gets
# strip = remove /n /t espaços etc
txt = txt.strip
# Vetor contendo o valor hexadecimal da tabela que representa cada caracter do txt buscado
txt_hexa = []
# fetch(key, default) => default = caso não encontre retorna esse valor
txt.each_char { |c| txt_hexa << table1.fetch(c, '1F') }
puts txt_hexa
