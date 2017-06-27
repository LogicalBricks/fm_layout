require 'fm_layout/fm_seccion'

module FmLayout
  class ComplementoIne
    include FmSeccion

    def initialize
      @titulo = 'ComplementoINE'
      @datos = {}
    end

    def self.campos_vs_metodos
      {
        'TipoProceso'    => 'tipo_proceso',
        'TipoComite'     => 'tipo_comite',
        'IdContabilidad' => 'id_contabilidad',
      }
    end

    # Creación de los métodos de acceso dinámicamente
    campos_vs_metodos.each do |campo, metodo|
      define_method(metodo) do |dato|
        @datos[campo] = dato
      end
    end

    private

  end
end
