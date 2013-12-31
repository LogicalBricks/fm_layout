module FmLayout
  module Nomina
    class Incapacidad

      include ::FmLayout::FmSeccion

      def initialize
        @titulo= 'Incapacidad'
        @datos= {}
        #valores_iniciales
      end

      def self.campos_vs_metodos
        {
          'DiasIncapacidad'      => 'dias',
          'TipoIncapacidad'      => 'tipo',
          'Descuento'            => 'descuento',
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
end
