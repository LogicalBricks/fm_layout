require 'fm_layout/fm_seccion'

module FmLayout
  class Receptor
    include FmSeccion

    def initialize separador = '|'
      @separador = separador
      @titulo = 'Receptor'
      @datos = {}
    end

    def self.campos_vs_metodos
      {
        'rfc'           => 'rfc',
        'nombre'        => 'nombre',
        'NumCliente'    => 'numero_de_cliente',
        'emailCliente'  => 'email',
      }
    end

    # Creación de los métodos de acceso dinámicamente
    campos_vs_metodos.each do |campo, metodo|
      define_method(metodo) do |dato|
        @datos[campo] = dato
      end
    end

  end
end
