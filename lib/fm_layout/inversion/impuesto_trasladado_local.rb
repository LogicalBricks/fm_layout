require 'fm_layout/inversion/fm_seccion'

module FmLayout
  module Inversion
    class ImpuestoTrasladadoLocal
      include FmSeccion

      def initialize
        @titulo = 'TrasladoLocal'
        @datos = {}
      end

      def self.campos_vs_metodos
        {
          'ImpLocTrasladado'  => 'impuesto',
          'Importe'           => 'importe',
          'TasadeTraslado'    => 'tasa',
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
