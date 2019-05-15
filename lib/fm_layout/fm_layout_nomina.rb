require 'fm_layout/datos_adicionales'
require 'fm_layout/entidad_sncf'
require 'fm_layout/recibo_nomina'
require 'fm_layout/nomina/nomina'
require 'fm_layout/cfdi_relacionados'

module FmLayout
  class FmLayoutNomina
    def initialize
      @recibo_nomina = ReciboNomina.new
      @datos_adicionales = DatosAdicionales.new
      @emisor = Nomina::Emisor.new
      @receptor= Nomina::Receptor.new
      @cfdi_relacionados = CfdiRelacionados.new
      @conceptos = []
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

    def entidad_sncf
      @entidad_sncf = EntidadSNCF.new
      if block_given?
        yield(@entidad_sncf)
      else
        @entidad_sncf
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
      concepto = Nomina::Concepto.new(@num_concepto)
      if block_given?
        yield(concepto)
        @conceptos << concepto
      else
        concepto
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

    def cfdi_relacionados
      if block_given?
        yield(@cfdi_relacionados)
      else
        @cfdi_relacionados
      end
    end

    def to_s
      salida = @recibo_nomina.to_s
      salida += @cfdi_relacionados.to_s if @cfdi_relacionados.con_relaciones?
      salida += @datos_adicionales.to_s + @emisor.to_s + @entidad_sncf.to_s + @receptor.to_s
      salida += @conceptos.map(&:to_s).reduce(:+).to_s
      salida += @nomina.to_s
      salida
    end

    def to_h
      recibo_nomina.to_h
        .merge(@datos_adicionales.to_h)
        .merge(@cfdi_relacionados.to_h)
        .merge(@emisor.to_h)
        .merge(@entidad_sncf.to_h)
        .merge(@expedido_en.to_h)
        .merge(@receptor.to_h)
        .merge(obtener_hash_conceptos)
        .merge(@nomina.to_h)
    end

    private

    def obtener_hash_conceptos
      { 'Conceptos' => @conceptos.map(&:to_h) }
    end

  end
end
