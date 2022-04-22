require 'fm_layout/comprobante_fiscal_digital'
require 'fm_layout/datos_adicionales'
require 'fm_layout/emisor'
require 'fm_layout/receptor'
require 'fm_layout/domicilio'
require 'fm_layout/concepto'
require 'fm_layout/impuesto_trasladado'
require 'fm_layout/impuesto_trasladado_local'
require 'fm_layout/impuesto_retenido'
require 'fm_layout/impuesto_retenido_local'
require 'fm_layout/complemento_ine'
require 'fm_layout/entidad_ine'
require 'fm_layout/cfdi_relacionados'
require 'pry'

module FmLayout
  class FmLayout
    def initialize
      @encabezado = ComprobanteFiscalDigital.new
      @datos_adicionales = DatosAdicionales.new
      @emisor = Emisor.new
      @receptor= Receptor.new
      @conceptos = []
      @entidades_ine  = []
      @num_concepto = 0

      @impuesto_trasladado = ImpuestoTrasladado.new
      @impuesto_retenido = ImpuestoRetenido.new
      @impuesto_trasladado_local = ImpuestoTrasladadoLocal.new
      @impuesto_retenido_local = ImpuestoRetenidoLocal.new
      @cfdi_relacionados = CfdiRelacionados.new
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
      @num_concepto += 1
      concepto = Concepto.new @num_concepto
      if block_given?
        yield(concepto)
        @conceptos << concepto
      else
        concepto
      end
    end

    def impuesto_trasladado
      if block_given?
        yield(@impuesto_trasladado)
      else
       @impuesto_trasladado
      end
    end

    def impuesto_trasladado_local
      if block_given?
        yield(@impuesto_trasladado_local)
      else
       @impuesto_trasladado_local
      end
    end

    def impuesto_retenido
      if block_given?
        yield(@impuesto_retenido)
      else
       @impuesto_retenido
      end
    end

    def impuesto_retenido_local
      if block_given?
        yield(@impuesto_retenido_local)
      else
        @impuesto_retenido_local
      end
    end

    def complemento_ine
      @complemento_ine = ComplementoIne.new
      if block_given?
        yield(@complemento_ine)
      else
        @complemento_ine
      end
    end

    def entidad_ine
      entidad = EntidadINE.new
      if block_given?
        yield(entidad)
        @entidades_ine << entidad
      else
        entidad
      end
    end

    def cfdi_relacionados
      if block_given?
        yield(@cfdi_relacionados)
      else
        @cfdi_relacionados
      end
    end

    def to_s
      salida = @encabezado.to_s
      salida += @cfdi_relacionados.to_s if @cfdi_relacionados.con_relaciones?
      salida += @datos_adicionales.to_s
      salida += @emisor.to_s
      salida += @receptor.to_s
      salida += @conceptos.map(&:to_s).reduce(:+).to_s
      salida += @impuesto_trasladado.to_s if @impuesto_trasladado.con_impuestos?
      salida += @impuesto_retenido.to_s if @impuesto_retenido.con_impuestos?
      salida += @impuesto_trasladado_local.to_s if @impuesto_trasladado_local.con_impuestos?
      salida += @impuesto_retenido_local.to_s if @impuesto_retenido_local.con_impuestos?
      salida += @complemento_ine.to_s
      salida += @entidades_ine.map(&:to_s).reduce(:+).to_s
      salida
    end

    def to_h
      encabezado.to_h
        .merge(@datos_adicionales.to_h)
        .merge(@emisor.to_h)
        .merge(@receptor.to_h)
        .merge(obtener_hash_conceptos)
        .merge(obtener_hash_traslados)
        .merge(obtener_hash_retenciones)
        .merge(obtener_hash_traslados_locales)
        .merge(obtener_hash_retenciones_locales)
        .merge(@complemento_ine.to_h)
        .merge(@cfdi_relacionados.to_h)
        .merge(obtener_hash_entidades_ine)
    end

    private

    def obtener_hash_conceptos
      { 'Conceptos' => @conceptos.map(&:to_h) }
    end

    def obtener_hash_retenciones
      {'ImpuestosRetenidos' => @impuesto_retenido.to_h }
    end

    def obtener_hash_traslados
      { 'ImpuestosTrasladados' => @impuesto_trasladado.to_h }
    end

    def obtener_hash_traslados_locales
      { 'ImpuestosTrasladadosLocales' => @impuesto_trasladado_local.to_h }
    end

    def obtener_hash_retenciones_locales
      { 'ImpuestosRetenidosLocales' => @impuesto_retenido_local.to_h }
    end

    def obtener_hash_entidades_ine
      { 'EntidadesINE' => @entidades_ine.map(&:to_h) }
    end
  end
end
