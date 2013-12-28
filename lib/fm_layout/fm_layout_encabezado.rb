module FmLayout
  class FmLayoutEncabezado
    def initialize
      @encabezado = {}
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
        @encabezado[campo] = dato
      end
    end

    def to_h
      @encabezado
    end

    def to_s
      salida = "[Encabezado]\r\n\r\n"
      @encabezado.each do |k,v|
        salida += "#{k}|#{v}\r\n"
      end
      salida
    end

    private

    def valores_iniciales
      @encabezado['fecha'] = 'asignarFecha'
      @encabezado['folio'] = 'asignarFolio'
    end
  end

end
