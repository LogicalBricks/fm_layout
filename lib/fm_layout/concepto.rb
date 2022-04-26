require 'fm_layout/fm_seccion'
require 'fm_layout/parte'

module FmLayout
  class Concepto
    include FmSeccion

    def initialize num_concepto
      @titulo = "Concepto##{num_concepto}"
      @datos = {}
      valores_iniciales
      @impuesto_t = ImpuestoTrasladado.new
      @impuesto_r = ImpuestoRetenido.new
      @parte      = Parte.new
      
    end

    def self.campos_vs_metodos
      {
        'ClaveProdServ'       => 'clave_producto_servicio',
        'NoIdentificacion'    => 'numero_de_identificacion',
        'Cantidad'            => 'cantidad',
        'ClaveUnidad'         => 'clave_unidad',
        'Unidad'              => 'unidad',
        'Descripcion'         => 'descripcion',
        'ValorUnitario'       => 'valor_unitario',
        'Importe'             => 'importe',
        'Descuento'           => 'descuento',
        'ObjetoImp'           => 'objeto_imp',
        'CuentaPredial'       => 'cuenta_predial'
      }
    end

    def partes
      if block_given?
        yield @parte
        @datos["Parte.ClaveProdServ"] = @parte.datos["ClaveProdServ"]
        @datos["Parte.NoIdentificacion"] = @parte.datos["NoIdentificacion"]
        @datos["Parte.Cantidad"] = @parte.datos["Cantidad"]
        @datos["Parte.Unidad"] = @parte.datos["Unidad"]
        @datos["Parte.Descripcion"] = @parte.datos["Descripcion"]
      else
        @parte
      end
    end

    def impuesto_trasladado
      if block_given?
        yield @impuesto_t
        @datos["Impuestos.Traslados.Base"] = @impuesto_t.datos["Base"]
        @datos["Impuestos.Traslados.Impuesto"] = @impuesto_t.datos["Impuesto"]
        @datos["Impuestos.Traslados.TipoFactor"] = @impuesto_t.datos["TipoFactor"]
        @datos["Impuestos.Traslados.TasaOCuota"] = @impuesto_t.datos["TasaOCuota"]
        @datos["Impuestos.Traslados.Importe"] = @impuesto_t.datos["Importe"]
      else
        @impuesto_t
      end
    end

    def impuesto_retenido
      if block_given?
        yield @impuesto_r
        @datos["Impuestos.Retenciones.Base"] = @impuesto_r.datos["Base"]
        @datos["Impuestos.Retenciones.Impuesto"] = @impuesto_r.datos["Impuesto"]
        @datos["Impuestos.Retenciones.TipoFactor"] = @impuesto_r.datos["TipoFactor"]
        @datos["Impuestos.Retenciones.TasaOCuota"] = @impuesto_r.datos["TasaOCuota"]
        @datos["Impuestos.Retenciones.Importe"] = @impuesto_r.datos["Importe"]
      else
        @impuesto_r
      end
    end

    def a_cuenta_terceros
      if block_given?
        yield @impuesto_r
        @datos["ACuentaTerceros.RfcACuentaTerceros"] = @impuesto_r.datos["RfcACuentaTerceros"]
        @datos["ACuentaTerceros.NombreACuentaTerceros"] = @impuesto_r.datos["NombreACuentaTerceros"]
        @datos["ACuentaTerceros.RegimenFiscalACuentaTerceros"] = @impuesto_r.datos["RegimenFiscalACuentaTerceros"]
        @datos["ACuentaTerceros.DomicilioFiscalACuentaTerceros"] = @impuesto_r.datos["DomicilioFiscalACuentaTerceros"]
      else
        @impuesto_r
      end
    end

    # Creación de los métodos de acceso dinámicamente
    campos_vs_metodos.each do |campo, metodo|
      define_method(metodo) do |dato|
        @datos[campo] = dato
      end
    end

    private

    def valores_iniciales
      @datos['Cantidad'] = 1
      @datos['ObjetoImp'] = '02'
    end
  end
end
