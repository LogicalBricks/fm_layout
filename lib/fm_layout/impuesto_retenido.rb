require 'fm_layout/fm_seccion'

module FmLayout
  class ImpuestoRetenido
    include FmSeccion

    def initialize
      @titulo = 'ImpuestoRetenido'
      @datos = {}
    end

    def self.campos_vs_metodos
      {
        'impuesto'       => 'impuesto',
        'importe'        => 'importe',
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
