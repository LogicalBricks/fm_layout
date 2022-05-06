require 'fm_layout/fm_seccion'
module FmLayout
  class ComprobanteFiscalDigital
    include FmSeccion

    def initialize
      @titulo= 'ComprobanteFiscalDigital'
      @datos= {}
      valores_iniciales
    end

    def self.campos_vs_metodos
      {
        'Serie'             => 'serie',
        'Folio'             => 'folio',
        'Fecha'             => 'fecha',
        'FormaPago'         => 'forma_de_pago',
        'NoCertificado'     => 'numero_de_certificado',
        'CondicionesDePago' => 'condiciones_de_pago',
        'SubTotal'          => 'subtotal',
        'Descuento'         => 'descuento',
        'Moneda'            => 'moneda',
        'Total'             => 'total',
        'TipoDeComprobante' => 'tipo_de_comprobante',
        'MetodoPago'        => 'metodo_de_pago',
        'LugarExpedicion'   => 'lugar_de_expedicion',
        'TipoCambio'        => 'tipo_de_cambio',
        'Exportacion'       => 'exportacion'
      }
    end

    # Creación de los métodos de acceso dinámicamente
    campos_vs_metodos.each do |campo, metodo|
      define_method(metodo) do |dato|
        @datos[campo] = dato
      end
    end


    private

    def valores_iniciales
      @datos['Version'] = '4.0'
      @datos['Fecha'] = nil
      @datos['Folio'] = nil
      @datos['NoCertificado'] = nil
      @datos['SubTotal'] = nil
      @datos['Descuento'] = nil
      @datos['Total'] = nil
      @datos['Exportacion'] = '01'
    end
  end

end
