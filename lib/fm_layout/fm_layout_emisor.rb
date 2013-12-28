module FmLayout
  class FmLayoutEmisor
    def initialize
      @datos = {}
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
        @datos[campo] = dato
      end
    end

    def to_h
      @datos
    end

    def to_s
      salida = "[Emisor]\r\n\r\n"
      @datos.each do |k,v|
        salida += "#{k}|#{v}\r\n"
      end
      salida
    end
  end
end
