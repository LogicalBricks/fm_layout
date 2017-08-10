require 'fm_layout/fm_seccion'
module FmLayout
  class ReciboNomina
    include FmSeccion

    def initialize
      @separador = '='
      @titulo= 'ReciboNomina'
      @datos= {}
      valores_iniciales
    end

    def self.campos_vs_metodos
      {
        'serie'               => 'serie',
        'folio'               => 'folio',
        'fecha'               => 'fecha',
        'subTotal'            => 'subtotal',
        'descuento'           => 'descuento',
        'total'               => 'total',
        'Moneda'              => 'moneda',
        'noCertificado'       => 'numero_de_certificado',
        'LugarExpedicion'     => 'lugar_de_expedicion',
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
      @datos['Version'] = '3.3'
      @datos['serie'] = nil
      @datos['folio'] = nil
      @datos['fecha'] = nil
      @datos['subTotal'] = nil
      @datos['descuento'] = nil
      @datos['total'] = nil
      @datos['noCertificado'] = nil
    end
  end

end
