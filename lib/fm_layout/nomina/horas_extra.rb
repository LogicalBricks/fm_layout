module FmLayout
  module Nomina
    class HorasExtra

      include ::FmLayout::FmSeccionNomina
      attr_reader :datos

      def initialize
        @titulo= 'HorasExtra'
        @datos= {}
        #valores_iniciales
      end

      def self.campos_vs_metodos
        {
          'Dias'           => 'dias',
          'TipoHoras'      => 'tipo',
          'HorasExtra'     => 'horas_extra',
          'ImportePagado'  => 'importe',
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
