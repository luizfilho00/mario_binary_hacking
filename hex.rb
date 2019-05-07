class HexEditor
  # Cria uma hash_map em @table contendo os dados de @table_file
  # Cria uma string @rom que recebe os bytes do arquivo @rom_file
  # Cria uma string @dump que contém os dados da @rom_file em hexadecimal
  def initialize(rom_file, table_file)
    begin
      @table = Hash[File.read(table_file).split("\n").map { |i| i.split('=') }]
    rescue StandardError => e
      abort('Tabela não econtrada.')
    end
    begin
      @rom = File.read(rom_file, mode: 'rb')
    rescue StandardError => e
      abort('Rom não encontrada.')
    end
    @dump = create_dump
  end

  # Quantidade de hexas no @dump
  def length
    @dump.length / 2
  end

  # Retorna o valor hexadecimal de @char mapeado na @table
  def get_hexa_code(char)
    @table.key(char) || '00'
  end

  # Retorna o caracter representado na tabela pelo valor @hexa
  # ou uma string vazia caso @hexa não se encontre na tablea
  def get_char(hexa)
    @table.fetch(hexa, '')
  end

  # Busca @text na dump e retorna seu valor hexadecimal
  def search(text)
    hexa_text = convert_text_to_hexa(text)
    !hexa_text.empty? ? string_like_hexa(hexa_text) : 'Texto não encontrado!'
  end

  # Retorna o offset de @text no @dump da rom
  def offset(text)
    index = @dump.index(convert_text_to_hexa(text))
    index ? (index / 2) : -1
  end

  # Converte a string @text para uma string contendo seus valores hexadecimais mapeados em @table
  private def convert_text_to_hexa(text)
    hexa_text = ''
    text.each_char { |c| hexa_text << get_hexa_code(c) }
    hexa_text
  end

  # Printa os valores hexadecimais separados por espaço
  private def string_like_hexa(text)
    text.gsub(/(.{2})/, '\1 ').strip
  end

  # Retorna uma string contendo o dump (representação hexadecimal) da @rom
  private def create_dump
    tmp_dump = ''
    @rom.each_byte.map { |b| tmp_dump << fix_hex_length(b.to_s(16)) }
    tmp_dump
  end

  # Garante que todo valor hexadecimal seja representado por 2 dígitos
  private def fix_hex_length(s)
    if s.length < 2
      ('0' + s).upcase
    else
      s.upcase
    end
  end
end
