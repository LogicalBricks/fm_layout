require 'fm_layout/encabezado'
require 'fm_layout/inversion/datos_adicionales'
require 'fm_layout/inversion/emisor'
require 'fm_layout/inversion/receptor'
require 'fm_layout/domicilio'
require 'fm_layout/inversion/concepto'
require 'fm_layout/inversion/impuesto_trasladado'
require 'fm_layout/inversion/impuesto_trasladado_local'
require 'fm_layout/inversion/impuesto_retenido'
require 'fm_layout/inversion/impuesto_retenido_local'

module FmLayout
  class FmLayoutInversion
    def initialize
      @encabezado = Encabezado.new
      @datos_adicionales = Inversion::DatosAdicionales.new
      @emisor = Inversion::Emisor.new
      @receptor= Inversion::Receptor.new
      @conceptos = []
      @impuestos_trasladados =  []
      @impuestos_trasladados_locales =  []
      @impuestos_retenidos =  []
      @impuestos_retenidos_locales = []
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
      @domicilio_fiscal ||= Domicilio.new('DomicilioFiscal')
      if block_given?
        yield(@domicilio_fiscal)
      else
        @domicilio_fiscal
      end
    end

    def domicilio
      @domicilio ||= Domicilio.new
      if block_given?
        yield(@domicilio)
      else
        @domicilio
      end
    end

    def expedido_en
      @expedido_en ||= Domicilio.new('ExpedidoEn')
      if block_given?
        yield(@expedido_en)
      else
        @expedido_en
      end
    end

    def concepto
      concepto = Inversion::Concepto.new
      if block_given?
        yield(concepto)
        @conceptos << concepto
      else
        concepto
      end
    end

    def impuesto_trasladado
      impuesto = Inversion::ImpuestoTrasladado.new
      if block_given?
        yield(impuesto)
        @impuestos_trasladados << impuesto
      else
        impuesto
      end
    end

    def impuesto_trasladado_local
      impuesto = Inversion::ImpuestoTrasladadoLocal.new
      if block_given?
        yield(impuesto)
        @impuestos_trasladados_locales << impuesto
      else
        impuesto
      end
    end

    def impuesto_retenido
      impuesto = Inversion::ImpuestoRetenido.new
      if block_given?
        yield(impuesto)
        @impuestos_retenidos << impuesto
      else
        impuesto
      end
    end

    def impuesto_retenido_local
      impuesto = Inversion::ImpuestoRetenidoLocal.new
      if block_given?
        yield(impuesto)
        @impuestos_retenidos_locales << impuesto
      else
        impuesto
      end
    end

    def to_s
      salida = @encabezado.to_s + @datos_adicionales.to_s + @emisor.to_s + @domicilio_fiscal.to_s + @expedido_en.to_s + @receptor.to_s + @domicilio.to_s
      salida += @conceptos.map(&:to_s).reduce(:+).to_s
      salida += @impuestos_trasladados.map(&:to_s).reduce(:+).to_s
      salida += @impuestos_retenidos.map(&:to_s).reduce(:+).to_s
      salida += @impuestos_trasladados_locales.map(&:to_s).reduce(:+).to_s
      salida += @impuestos_retenidos_locales.map(&:to_s).reduce(:+).to_s
      salida
    end

    def to_h
      encabezado.to_h
        .merge(@datos_adicionales.to_h)
        .merge(@emisor.to_h)
        .merge(@domicilio_fiscal.to_h)
        .merge(@expedido_en.to_h)
        .merge(@receptor.to_h)
        .merge(@domicilio.to_h)
        .merge(obtener_hash_conceptos)
        .merge(obtener_hash_traslados)
        .merge(obtener_hash_retenciones)
        .merge(obtener_hash_traslados_locales)
        .merge(obtener_hash_retenciones_locales)
    end

    private

    def obtener_hash_conceptos
      { 'Conceptos' => @conceptos.map(&:to_h) }
    end

    def obtener_hash_retenciones
      {'ImpuestosRetenidos' => @impuestos_retenidos.map(&:to_h) }
    end

    def obtener_hash_traslados
      { 'ImpuestosTrasladados' => @impuestos_trasladados.map(&:to_h) }
    end

    def obtener_hash_traslados_locales
      { 'ImpuestosTrasladadosLocales' => @impuestos_trasladados_locales.map(&:to_h) }
    end

    def obtener_hash_retenciones_locales
      { 'ImpuestosRetenidosLocales' => @impuestos_retenidos_locales.map(&:to_h) }
    end
  end
end
