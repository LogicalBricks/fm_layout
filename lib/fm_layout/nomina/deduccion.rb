module FmLayout
  module Nomina
    class Deduccion

      include ::FmLayout::FmSeccion

      def initialize
        @titulo = 'Deduccion'
        @datos  = {}
      end

      def self.campos_vs_metodos
        {
          'TipoDeduccion' => 'tipo',
          'Clave'         => 'clave',
          'Concepto'      => 'concepto',
          'Importe'       => 'importe',
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
