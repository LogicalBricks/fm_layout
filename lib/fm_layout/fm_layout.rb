require 'fm_layout/fm_layout_encabezado'
require 'fm_layout/fm_layout_datos_adicionales'
require 'fm_layout/fm_layout_emisor'
require 'fm_layout/fm_layout_receptor'
require 'fm_layout/fm_layout_domicilio'

module FmLayout
  class FmLayout
    def initialize
      @encabezado = FmLayoutEncabezado.new
      @datos_adicionales = FmLayoutDatosAdicionales.new
      @emisor = FmLayoutEmisor.new
      @domicilio_fiscal = FmLayoutDomicilio.new('DomicilioFiscal')
      @domicilio= FmLayoutDomicilio.new
      @receptor= FmLayoutReceptor.new
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

    def receptor
      if block_given?
        yield(@receptor)
      else
        @receptor
      end
    end


    def domicilio_fiscal
      if block_given?
        yield(@domicilio_fiscal)
      else
        @domicilio_fiscal
      end
    end

    def domicilio
      if block_given?
        yield(@domicilio)
      else
        @domicilio
      end
    end

    def expedido_en
      @expedido_en = FmLayoutDomicilio.new('ExpedidoEn')
      if block_given?
        yield(@expedido_en)
      else
        @expedido_en
      end
    end

    def to_s
      salida = @encabezado.to_s
      salida += @datos_adicionales.to_s if @datos_adicionales
      salida +=  @emisor.to_s if @emisor
      salida +=  @domicilio_fiscal.to_s if @domicilio_fiscal
      salida += @expedido_en.to_s if @expedido_en
      salida += @receptor.to_s if @receptor
      salida += @domicilio.to_s if @domicilio
      salida
    end

    def to_h
      hash = {}
      hash.merge!({ @encabezado.titulo => @encabezado.to_h}) if @encabezado
      hash.merge!({ @datos_adicionales.titulo => @datos_adicionales.to_h}) if @datos_adicionales
      hash.merge!({ @emisor.titulo => @emisor.to_h}) if @emisor
      hash.merge!({ @domicilio_fiscal.titulo => @domicilio_fiscal.to_h}) if @domicilio_fiscal
      hash.merge!({ @expedido_en.titulo => @expedido_en.to_h}) if @expedido_en
      hash.merge!({ @receptor.titulo => @receptor.to_h}) if @receptor
      hash.merge!({ @domicilio.titulo => @domicilio.to_h}) if @domicilio
      hash
    end
  end
end
