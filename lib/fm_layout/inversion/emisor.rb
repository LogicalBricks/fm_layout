require 'fm_layout/inversion/fm_seccion'

module FmLayout
  module Inversion
    class Emisor
      include FmSeccion

      def initialize
        @titulo = 'Emisor'
        @datos = {}
        valores_iniciales
      end

      def self.campos_vs_metodos
        {
          'rfc'           => 'rfc',
          'nombre'        => 'nombre',
          'RegimenFiscal' => 'regimen_fiscal',
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
        @datos['rfc'] = nil
        @datos['nombre'] = nil
        @datos['RegimenFiscal'] = nil
      end

    end
  end
end
