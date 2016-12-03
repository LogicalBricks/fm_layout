module FmLayout
  module Nomina
    class Incapacidad

      include ::FmLayout::FmSeccion

      def initialize
        @titulo = 'Incapacidad'
        @datos  = {}
      end

      def self.campos_vs_metodos
        {
          'DiasIncapacidad'  => 'dias',
          'TipoIncapacidad'  => 'tipo',
          'ImporteMonetario' => 'importe_monetario',
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
