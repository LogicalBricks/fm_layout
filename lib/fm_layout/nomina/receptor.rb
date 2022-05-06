module FmLayout
  module Nomina
    class Receptor
      include ::FmLayout::FmSeccion

      def initialize
        @titulo = 'Receptor'
        @datos = {}
      end

      def self.campos_vs_metodos
        {
          'rfc'                    => 'rfc',
          'nombre'                 => 'nombre',
          'Curp'                   => 'curp',
          'NumSeguridadSocial'     => 'numero_seguridad_social',
          'FechaInicioRelLaboral'  => 'fecha_inicio_relacion_laboral',
          'Antigüedad'             => 'antiguedad',
          'TipoContrato'           => 'tipo_contrato',
          'TipoJornada'            => 'tipo_jornada',
          'TipoRegimen'            => 'tipo_regimen',
          'NumEmpleado'            => 'numero_empleado',
          'Departamento'           => 'departamento',
          'Puesto'                 => 'puesto',
          'RiesgoPuesto'           => 'riesgo_puesto',
          'PeriodicidadPago'       => 'periodicidad_pago',
          'Banco'                  => 'banco',
          'CuentaBancaria'         => 'cuenta_bancaria',
          'SalarioBaseCotApor'     => 'salario_base',
          'SalarioDiarioIntegrado' => 'salario_diario_integrado',
          'ClaveEntFed'            => 'clave_entidad_federativa',
          'emailCliente'           => 'email',
          'UsoCFDI'                  => 'uso_cfdi',
          'DomicilioFiscalReceptor'  => 'domicilio_fiscal_receptor',
          'RegimenFiscalReceptor'    => 'regimen_fiscal_receptor'
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
