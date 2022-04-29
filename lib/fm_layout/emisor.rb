require 'fm_layout/fm_seccion'

module FmLayout
  class Emisor
    include FmSeccion

    def initialize
      @titulo = 'Emisor'
      @datos = {}
      valores_iniciales
    end

    def self.campos_vs_metodos
      {
        'Rfc'              => 'rfc',
        'Nombre'           => 'nombre',
        'RegimenFiscal'    => 'regimen_fiscal',
        'FacAtrAdquirente' => 'fac_atr_adquirente'
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
      @datos['Rfc'] = nil
      @datos['Nombre'] = nil
    end

  end
end
