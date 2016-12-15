module FmLayout
  module Nomina
    class ComplementoNomina

      include ::FmLayout::FmSeccionNomina

      def initialize
        @titulo= 'ComplementoNomina'
        @datos= {}
        #valores_iniciales
      end

      def self.campos_vs_metodos
        {
          'RegistroPatronal'       => 'registro_patronal',
          'NumEmpleado'            => 'numero_de_empleado',
          'CURP'                   => 'curp',
          'TipoRegimen'            => 'tipo_de_regimen',
          'NumSeguridadSocial'     => 'numero_de_seguridad_social',
          'FechaPago'              => 'fecha_de_pago',
          'FechaInicialPago'       => 'fecha_inicial_de_pago',
          'FechaFinalPago'         => 'fecha_final_de_pago',
          'NumDiasPagados'         => 'dias_pagados',
          'TotalPercepciones'      => 'total_percepciones',
          'Departamento'           => 'departamento',
          'CLABE'                  => 'clabe',
          'Banco'                  => 'banco',
          'FechaInicioRelLaboral'  => 'inicio_de_relacion_laboral',
          'Antiguedad'             => 'antiguedad',
          'Puesto'                 => 'puesto',
          'TipoContrato'           => 'tipo_de_contrato',
          'TipoJornada'            => 'tipo_de_jornada',
          'PeriodicidadPago'       => 'periodicidad_de_pago',
          'SalarioBaseCotApor'     => 'salario_base',
          'RiesgoPuesto'           => 'riesgo_del_puesto',
          'SalarioDiarioIntegrado' => 'salario_diario_integrado',
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
