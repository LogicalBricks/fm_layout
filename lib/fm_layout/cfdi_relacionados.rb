require 'fm_layout/fm_seccion'

module FmLayout
  class CfdiRelacionados
    include FmSeccion
    attr_reader :datos

    def initialize
      @titulo = 'CfdiRelacionados'
      @datos = {}
    end

    def tipo_relacion value
      @datos["TipoRelacion"] = value
    end

    def uuids value
      @datos["UUID"] = "[#{value}]"
    end

    def con_relaciones?
      @datos.any?
    end
  end
end
