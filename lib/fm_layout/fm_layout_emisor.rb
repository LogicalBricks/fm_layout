require 'fm_layout/fm_seccion'

module FmLayout
  class FmLayoutEmisor
    include FmSeccion

    def initialize
      @titulo = 'Emisor'
      @datos = {}
    end

    def self.campos_vs_metodos
      {
        'rfc'           => 'rfc',
        'nombre'        => 'nombre',
        'RegimenFiscal' => 'regimen_fiscal',
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
