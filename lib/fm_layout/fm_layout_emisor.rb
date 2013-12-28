module FmLayout
  class FmLayoutEmisor
    def initialize
      @emisor = {}
    end

    def self.campos_vs_metodos
      {
        'rfc'           => 'rfc',
        'nombre'        => 'nombre',
        'RegimenFiscal' => 'regimen_fiscal',
      }
    end

    # Creación de los métodos de acceso dinámicamente
    campos_vs_metodos.each do |campo, metodo|
      define_method(metodo) do |dato|
        @emisor[campo] = dato
      end
    end

    def to_h
      @emisor
    end

    def to_s
      salida = "[Emisor]\r\n\r\n"
      @emisor.each do |k,v|
        salida += "#{k}|#{v}\r\n"
      end
      salida
    end
  end
end
