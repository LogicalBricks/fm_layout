module FmLayout
  module Nomina
    class Emisor
      include ::FmLayout::FmSeccion

      def initialize
        @titulo = 'Emisor'
        @datos = {}
        valores_iniciales
      end

      def self.campos_vs_metodos
        {
          'rfc'              => 'rfc',
          'nombre'           => 'nombre',
          'Regimen'          => 'regimen',
          'RegimenFiscal'    => 'regimen_fiscal',
          'Curp'             => 'curp',
          'RegistroPatronal' => 'registro_patronal',
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
      end

    end
  end
end
