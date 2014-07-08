require 'fm_layout/fm_seccion'

module FmLayout
  class ImpuestoRetenidoLocal
    include FmSeccion

    def initialize
      @titulo = 'RetencionLocal'
      @datos = {}
    end

    def self.campos_vs_metodos
      {
        'ImpLocRetenido'    => 'impuesto',
        'Importe'           => 'importe',
        'TasadeTraslado'    => 'tasa',
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
