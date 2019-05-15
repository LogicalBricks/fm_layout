require 'fm_layout/fm_seccion'

module FmLayout
  class Parte
    include FmSeccion
    attr_reader :datos
    attr_accessor :arr_clave, :arr_no_identificacion, :arr_cantidad, :arr_unidad, :arr_descripcion

    def initialize
      @arr_clave = []
      @arr_no_identificacion = []
      @arr_cantidad = []
      @arr_unidad = []
      @arr_descripcion = []
      @datos = {}
    end

    def self.campos_vs_metodos
      {
        'ClaveProdServ'       => 'clave_producto_servicio',
        'NoIdentificacion'    => 'numero_de_identificacion',
        'Cantidad'            => 'cantidad',
        'Unidad'              => 'unidad',
        'Descripcion'         => 'descripcion',
      }
    end

    def clave_producto_servicio value
      arr_clave.push value
      @datos["ClaveProdServ"] = "[#{arr_clave.join(',')}]"
    end

    def numero_de_identificacion value
      arr_no_identificacion.push value
      @datos["NoIdentificacion"] = "[#{arr_no_identificacion.join(',')}]"
    end

    def cantidad value
      arr_cantidad.push value
      @datos["Cantidad"] = "[#{arr_cantidad.join(',')}]"
    end

    def unidad value
      arr_unidad.push value 
      @datos["Unidad"] = "[#{arr_unidad.join(',')}]"
    end

    def descripcion value
      arr_descripcion.push value 
      @datos["Descripcion"] = "[#{arr_descripcion.join(',')}]"
    end
  end
end
