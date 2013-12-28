module FmLayout
  class FmLayoutDomicilioFiscal
    def initialize
      @datos = {}
    end

    def self.campos_vs_metodos
      {
        'calle'           => 'calle',
        'noExterior'      => 'numero_exterior',
        'noInterior'      => 'numero_interior',
        'colonia'         => 'colonia',
        'localidad'       => 'localidad',
        'municipio'       => 'municipio',
        'estado'          => 'estado',
        'pais'            => 'pais',
        'codigoPostal'    => 'codigo_postal',
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
      salida = "[DomicilioFiscal]\r\n\r\n"
      @datos.each do |k,v|
        salida += "#{k}|#{v}\r\n"
      end
      salida
    end
  end
end
