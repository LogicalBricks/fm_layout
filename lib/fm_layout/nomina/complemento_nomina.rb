module FmLayout
  module Nomina
    class ComplementoNomina

      include ::FmLayout::FmSeccion

      def initialize
        @titulo= 'ComplementoNomina'
        @datos= {}
        valores_iniciales
      end

      def self.campos_vs_metodos
        {
          'TipoNomina'        => 'tipo_nomina',
          'FechaPago'         => 'fecha_de_pago',
          'FechaInicialPago'  => 'fecha_inicial_de_pago',
          'FechaFinalPago'    => 'fecha_final_de_pago',
          'NumDiasPagados'    => 'dias_pagados',
          'TotalPercepciones' => 'total_percepciones',
          'TotalDeducciones'  => 'total_deducciones',
          'TotalOtrosPagos'   => 'total_otros_pagos',
        }
      end

      # Creación de los métodos de acceso dinámicamente
      campos_vs_metodos.each do |campo, metodo|
        define_method(metodo) do |dato|
          @datos[campo] = dato
        end
      end

      def valores_iniciales
        @datos['Version'] = '1.2'
      end

    end
  end
end
