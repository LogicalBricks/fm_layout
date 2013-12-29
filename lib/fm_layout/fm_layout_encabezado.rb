require 'fm_layout/fm_seccion'
module FmLayout
  class FmLayoutEncabezado
    include FmSeccion

    def initialize
      @titulo= 'Encabezado'
      @datos= {}
      valores_iniciales
    end

    def self.campos_vs_metodos
      {
        'serie'               => 'serie',
        'fecha'               => 'fecha',
        'folio'               => 'folio',
        'tipoDeComprobante'   => 'tipo_de_comprobante',
        'formaDePago'         => 'forma_de_pago',
        'metodoDePago'        => 'metodo_de_pago',
        'condicionesDePago'   => 'condiciones_de_pago',
        'NumCtaPago'          => 'numero_de_cuenta_de_pago',
        'subTotal'            => 'subtotal',
        'descuento'           => 'descuento',
        'total'               => 'total',
        'Moneda'              => 'moneda',
        'TipoCambio'          => 'tipo_de_cambio',
        'noCertificado'       => 'numero_de_certificado',
        'LugarExpedicion'     => 'lugar_de_expedicion'
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
      @datos['fecha'] = 'asignarFecha'
      @datos['folio'] = 'asignarFolio'
    end
  end

end
