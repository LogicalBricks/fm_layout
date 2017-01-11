module FmLayout
  module Nomina
    class SeparacionIndemnizacion

      include ::FmLayout::FmSeccionNomina

      def initialize
        @titulo = 'SeparacionIndemnizacion'
        @datos  = {}
      end

      def self.campos_vs_metodos
        {
          'TotalPagado'         => 'total_pagado',
          'NumAñosServicio'     => 'numero_anios_servicio',
          'UltimoSueldoMensOrd' => 'ultimo_sueldo_mensual',
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
