require 'fm_layout/fm_seccion'

module FmLayout
  class Concepto
    include FmSeccion

    def initialize separador, num_concepto
      @separador = separador
      @titulo = num_concepto ? "Concepto##{num_concepto}" : 'Concepto'
      @datos = {}
      valores_iniciales
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

    private

    def valores_iniciales
      @datos['cantidad']    = 1
      @datos['unidad']      = 'ACT'
      @datos['descripcion'] = 'Pago de nómina'
    end
  end
end
