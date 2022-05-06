require 'fm_layout/fm_seccion'
module FmLayout
  class ReciboPago
    include FmSeccion

    def initialize
      @titulo= 'ReciboPagos'
      @datos= {}
      valores_iniciales
    end

    def self.campos_vs_metodos
      {
        'Serie'             => 'serie',
        'Folio'             => 'folio',
        'Fecha'             => 'fecha',
        'NoCertificado'     => 'numero_de_certificado',
        'Moneda'            => 'moneda',
        'TipoDeComprobante' => 'tipo_de_comprobante',
        'LugarExpedicion'   => 'lugar_de_expedicion',
        'TipoCambio'        => 'tipo_de_cambio'
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
      @datos['Fecha'] = nil
      @datos['Folio'] = nil
      @datos['NoCertificado'] = nil
    end
  end

end
