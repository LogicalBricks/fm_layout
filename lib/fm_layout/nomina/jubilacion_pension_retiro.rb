module FmLayout
  module Nomina
    class JubilacionPensionRetiro

      include ::FmLayout::FmSeccionNomina

      def initialize
        @titulo = 'JubilacionPensionRetiro'
        @datos  = {}
      end

      def self.campos_vs_metodos
        {
          'TotalUnaExhibicion'  => 'total_una_exhibicion',
          'TotalParcialidad'    => 'total_parcialidad',
          'MontoDiario'         => 'monto_diario',
          'IngresoAcumulable'   => 'ingreso_acumulable',
          'IngresoNoAcumulable' => 'ingreso_no_acumulable',
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
