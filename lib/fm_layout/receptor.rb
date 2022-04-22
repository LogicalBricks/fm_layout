require 'fm_layout/fm_seccion'

module FmLayout
  class Receptor
    include FmSeccion

    def initialize
      @titulo = 'Receptor'
      @datos = {}
    end

    def self.campos_vs_metodos
      {
        'Rfc'                      => 'rfc',
        'Nombre'                   => 'nombre',
        'UsoCFDI'                  => 'uso_cfdi',
        'DomicilioFiscalReceptor'  => 'domicilio_fiscal',
        'RegimenFiscalReceptor'    => 'regimen_fiscal'
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
