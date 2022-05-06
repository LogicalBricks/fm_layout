require 'fm_layout/fm_seccion'

module FmLayout
  class ImpuestoTrasladadoLocal
    include FmSeccion
    attr_accessor :arr_impuesto, :arr_tasa, :arr_importe

    def initialize
      @titulo = 'TrasladosLocales'
      @arr_impuesto = []
      @arr_tasa = []
      @arr_importe = []
      @datos = {}
    end

    def impuesto value
      arr_impuesto.push value
      @datos["ImpLocTrasladado"] = "[#{arr_impuesto.join(',')}]"
    end

    def tasa value
      arr_tasa.push value
      @datos["TasadeTraslado"] = "[#{arr_tasa.join(',')}]"
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
