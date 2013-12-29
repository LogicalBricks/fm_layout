require 'fm_layout/fm_seccion'

module FmLayout
  class FmLayoutDomicilioFiscal
    include FmSeccion

    def initialize(titulo = 'DomicilioFiscal')
      @titulo = titulo
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

  end
end
