require 'fm_layout/fm_layout_encabezado'
require 'fm_layout/fm_layout_datos_adicionales'
require 'fm_layout/fm_layout_emisor'

module FmLayout
  class FmLayout
    def initialize
      @encabezado = FmLayoutEncabezado.new
      @datos_adicionales = FmLayoutDatosAdicionales.new
      @emisor = FmLayoutEmisor.new
    end

    def encabezado
      if block_given?
        yield(@encabezado)
      else
        @encabezado
      end
    end

    def datos_adicionales
      if block_given?
        yield(@datos_adicionales)
      else
        @datos_adicionales
      end
    end

    def emisor
      if block_given?
        yield(@emisor)
      else
        @emisor
      end
    end

    def to_s
      @encabezado.to_s +
        @datos_adicionales.to_s +
        @emisor.to_s
    end

    def to_h
      { 'Encabezado' => @encabezado.to_h,
        'Datos Adicionales' => @datos_adicionales.to_h,
        'Emisor' => @emisor.to_h
      }
    end
  end
end
