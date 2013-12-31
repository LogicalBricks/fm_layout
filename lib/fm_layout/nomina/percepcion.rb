module FmLayout
  module Nomina
    class Percepcion

      include ::FmLayout::FmSeccion

      def initialize
        @titulo= 'Percepcion'
        @datos= {}
        #valores_iniciales
      end

      def self.campos_vs_metodos
        {
          'TipoPercepcion'       => 'tipo',
          'Clave'                => 'clave',
          'Concepto'             => 'concepto',
          'ImporteGravado'       => 'importe_gravado',
          'ImporteExento'        => 'importe_exento',
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
