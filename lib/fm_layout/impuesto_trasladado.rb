require 'fm_layout/fm_seccion'
require 'pry'

module FmLayout
  class ImpuestoTrasladado
    include FmSeccion
    attr_reader :datos
    attr_accessor :arr_base, :arr_impuesto, :arr_tipo_factor, :arr_tasa_o_cuota, :arr_importe

    def initialize
      @titulo = 'Traslados'
      @arr_base = []
      @arr_impuesto = []
      @arr_tipo_factor = []
      @arr_tasa_o_cuota = []
      @arr_importe = []
      @datos = {}
    end

    def self.campos_vs_metodos
      {
        'TotalImpuestosTrasladados' => 'total_impuestos',
      }
    end

    # Creación de los métodos de acceso dinámicamente
    campos_vs_metodos.each do |campo, metodo|
      define_method(metodo) do |dato|
        @datos[campo] = dato
      end
    end

    def base value
      arr_base.push value
      @datos["Base"] = "[#{arr_base.join(',')}]"
    end

    def impuesto value
      arr_impuesto.push value
      @datos["Impuesto"] = "[#{arr_impuesto.join(',')}]"
    end

    def tipo_factor value
      arr_tipo_factor.push value
      @datos["TipoFactor"] = "[#{arr_tipo_factor.join(',')}]"
    end

    def tasa_o_cuota value
      arr_tasa_o_cuota.push value
      @datos["TasaOCuota"] = "[#{arr_tasa_o_cuota.join(',')}]"
    end

    def importe value
      arr_importe.push value
      @datos["Importe"] = "[#{arr_importe.join(',')}]"
    end

    def con_impuestos?
      @datos.any?
    end
  end
end
