require 'fm_layout/fm_seccion'

module FmLayout
  class FmLayoutConcepto
    include FmSeccion

    def initialize
      @titulo = 'Concepto'
      @datos = {}
    end

    def self.campos_vs_metodos
      {
        'cantidad'            => 'cantidad',
        'unidad'              => 'unidad',
        'noIdentificacion'    => 'numero_de_identificacion',
        'descripcion'         => 'descripcion',
        'valorUnitario'       => 'valor_unitario',
        'importe'             => 'importe',
        'CuentaPredial'       => 'cuenta_predial',
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
