require 'fm_layout/datos_adicionales'
require 'fm_layout/emisor'
require 'fm_layout/receptor'
require 'fm_layout/concepto'
require 'fm_layout/impuesto_trasladado'
require 'fm_layout/impuesto_trasladado_local'
require 'fm_layout/impuesto_retenido'
require 'fm_layout/impuesto_retenido_local'
require 'fm_layout/recibo_nomina'
require 'fm_layout/nomina/nomina'

module FmLayout
  class FmLayoutNomina
    def initialize
      @recibo_nomina = ReciboNomina.new
      @datos_adicionales = DatosAdicionales.new('=')
      @emisor = Emisor.new('=')
      @receptor= Receptor.new('=')
      @conceptos = []
      @impuestos_trasladados =  []
      @impuestos_trasladados_locales =  []
      @impuestos_retenidos =  []
      @impuestos_retenidos_locales = []
      @num_concepto = 0
    end

    def recibo_nomina
      if block_given?
        yield(@recibo_nomina)
      else
        @recibo_nomina
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

    def concepto
      @num_concepto += 1
      concepto = Concepto.new('=', @num_concepto)
      if block_given?
        yield(concepto)
        @conceptos << concepto
      else
        concepto
      end
    end

    def impuesto_trasladado
      impuesto = ImpuestoTrasladado.new
      if block_given?
        yield(impuesto)
        @impuestos_trasladados << impuesto
      else
       impuesto
      end
    end

    def impuesto_trasladado_local
      impuesto = ImpuestoTrasladadoLocal.new
      if block_given?
        yield(impuesto)
        @impuestos_trasladados_locales << impuesto
      else
       impuesto
      end
    end

    def impuesto_retenido
      impuesto = ImpuestoRetenido.new
      if block_given?
        yield(impuesto)
        @impuestos_retenidos << impuesto
      else
       impuesto
      end
    end

    def impuesto_retenido_local 
      impuesto = ImpuestoRetenidoLocal.new
      if block_given?
        yield(impuesto)
        @impuestos_retenidos_locales << impuesto
      else
        impuesto
      end
    end

    def nomina
      @nomina = Nomina::Nomina.new
      if block_given?
        yield(@nomina)
      else
        @nomina
      end
    end

    def to_s
      salida = @recibo_nomina.to_s + @datos_adicionales.to_s + @emisor.to_s + @receptor.to_s
      salida += @conceptos.map(&:to_s).reduce(:+).to_s
      salida += @impuestos_trasladados.map(&:to_s).reduce(:+).to_s
      salida += @impuestos_retenidos.map(&:to_s).reduce(:+).to_s
      salida += @impuestos_trasladados_locales.map(&:to_s).reduce(:+).to_s
      salida += @impuestos_retenidos_locales.map(&:to_s).reduce(:+).to_s
      salida += @nomina.to_s
      salida
    end

    def to_h
      recibo_nomina.to_h
        .merge(@datos_adicionales.to_h)
        .merge(@emisor.to_h)
        .merge(@expedido_en.to_h)
        .merge(@receptor.to_h)
        .merge(obtener_hash_conceptos)
        .merge(obtener_hash_traslados)
        .merge(obtener_hash_retenciones)
        .merge(@nomina.to_h)
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
