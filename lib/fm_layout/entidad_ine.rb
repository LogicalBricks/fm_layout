require 'fm_layout/fm_seccion'

module FmLayout
  class EntidadINE
    include FmSeccion

    def initialize
      @titulo = 'Entidad'
      @datos = {}
    end

    def self.campos_vs_metodos
      {
        'ClaveEntidad'   => 'clave_entidad',
        'Ambito'         => 'ambito',
        'IdContabilidad' => 'id_contabilidad',
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
