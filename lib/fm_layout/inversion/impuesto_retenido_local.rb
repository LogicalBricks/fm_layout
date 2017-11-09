require 'fm_layout/inversion/fm_seccion'

module FmLayout
  module Inversion
    class ImpuestoRetenidoLocal
      include FmSeccion

      def initialize
        @titulo = 'RetencionLocal'
        @datos = {}
      end

      def self.campos_vs_metodos
        {
          'ImpLocRetenido'    => 'impuesto',
          'Importe'           => 'importe',
          'TasadeRetencion'    => 'tasa',
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
