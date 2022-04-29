require 'fm_layout/fm_seccion'

module FmLayout
  class ACuentaTerceros
    include FmSeccion
    attr_reader :datos
    attr_accessor :rfc_cuenta_terceros, :nombre_cuenta_terceros, :regimen_fiscal_cuenta_terceros, :domicilio_fiscal_cuenta_terceros

    def initialize
      @titulo = 'ACuentaTerceros'
      @rfc_cuenta_terceros = ''
      @nombre_cuenta_terceros = ''
      @regimen_fiscal_cuenta_terceros = ''
      @domicilio_fiscal_cuenta_terceros = ''
      @datos = {}
    end

    def self.campos_vs_metodos
      {
        'RfcACuentaTerceros'    => 'rfc_cuenta_terceros',
        'NombreACuentaTerceros' => 'nombre_cuenta_terceros',
        'RegimenFiscalACuentaTerceros' => 'regimen_fiscal_cuenta_terceros',
        'DomicilioFiscalACuentaTerceros' => 'domicilio_fiscal_cuenta_terceros'
      }
    end

    # Creación de los métodos de acceso dinámicamente
    campos_vs_metodos.each do |campo, metodo|
      define_method(metodo) do |dato|
        @datos[campo] = dato
      end
    end
  end
end
