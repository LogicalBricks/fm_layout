module FmLayout
  class FmLayoutDatosAdicionales
    def initialize
      @datos= {}
    end

    def self.campos_vs_metodos
      {
        'tipoDocumento'       => 'tipo_de_documento',
        'numeropedido'        => 'numero_de_pedido',
        'observaciones'       => 'observaciones',
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
      salida = "[Datos Adicionales]\r\n\r\n"
      @datos.each do |k,v|
        salida += "#{k}|#{v}\r\n"
      end
      salida
    end
  end
end
