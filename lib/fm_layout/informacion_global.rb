require 'fm_layout/fm_seccion'
module FmLayout
  class InformacionGlobal
    include FmSeccion

    def initialize
      @titulo= 'InformacionGlobal'
      @datos= {}
      valores_iniciales
    end

    def self.campos_vs_metodos
      {
        'Periodicidad'             => 'periodicidad',
        'Meses'             => 'meses',
        'Año'             => 'anio',
        
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
    end
  end

end
