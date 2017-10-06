require 'fm_layout/fm_seccion'
require 'fm_layout/documento_relacionado'

module FmLayout
  class Pago
    include FmSeccion

    def initialize
      @titulo = "Pago#1"
      @datos = {}
      @documento_relacionado = DocumentoRelacionado.new
    end

    def self.campos_vs_metodos
      {
        'FechaPago'       => 'fecha_pago',
        'FormaDePagoP'    => 'forma_de_pago',
        'MonedaP'         => 'moneda',
        'TipoCambioP'     => 'tipo_cambio',
        'Monto'           => 'monto',
        'NumOperacion'    => 'numero_operacion',
        'RfcEmisorCtaOrd' => 'rfc_emisor_cuenta_ordenante',
        'NomBancoOrdExt'  => 'nombre_banco_ordenante',
        'CtaOrdenante'    => 'numero_cuenta_ordenante',
        'RfcEmisorCtaBen' => 'rfc_emisor_cuenta_beneficiario',
        'CtaBeneficiario' => 'numero_cuenta_beneficiario',
        'TipoCadPago'     => 'tipo_cadena_pago',
        'CertPago'        => 'cetificado_pago',
        'CadPago'         => 'cadena_pago',
        'SelloPago'       => 'sello_pago',
      }
    end

    def documento_relacionado
      if block_given?
        yield @documento_relacionado
        @datos["DoctoRelacionado.IdDocumento"] = @documento_relacionado.datos["IdDocumento"]
        @datos["DoctoRelacionado.Serie"] = @documento_relacionado.datos["Serie"]
        @datos["DoctoRelacionado.Folio"] = @documento_relacionado.datos["Folio"]
        @datos["DoctoRelacionado.MonedaDR"] = @documento_relacionado.datos["MonedaDR"]
        @datos["DoctoRelacionado.TipoCambioDR"] = @documento_relacionado.datos["TipoCambioDR"]
        @datos["DoctoRelacionado.MetodoDePagoDR"] = @documento_relacionado.datos["MetodoDePagoDR"]
        @datos["DoctoRelacionado.NumParcialidad"] = @documento_relacionado.datos["NumParcialidad"]
        @datos["DoctoRelacionado.ImpSaldoAnt"] = @documento_relacionado.datos["ImpSaldoAnt"]
        @datos["DoctoRelacionado.ImpPagado"] = @documento_relacionado.datos["ImpPagado"]
        @datos["DoctoRelacionado.ImpSaldoInsoluto"] = @documento_relacionado.datos["ImpSaldoInsoluto"]
      else
        @documento_relacionado
      end
    end

    # Creación de los métodos de acceso dinámicamente
    campos_vs_metodos.each do |campo, metodo|
      define_method(metodo) do |dato|
        @datos[campo] = dato
      end
    end
  end
end
