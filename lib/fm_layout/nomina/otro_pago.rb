module FmLayout
  module Nomina
    class OtroPago

      include ::FmLayout::FmSeccionNomina
      attr_reader :datos

      def initialize num_pago
        @titulo= "OtroPago##{num_pago}"
        @datos= {}
        #valores_iniciales
      end

      def self.campos_vs_metodos
        {
          'TipoOtroPago' => 'tipo',
          'Clave'        => 'clave',
          'Concepto'     => 'concepto',
          'Importe'      => 'importe',
        }
      end

      # Creación de los métodos de acceso dinámicamente
      campos_vs_metodos.each do |campo, metodo|
        define_method(metodo) do |dato|
          @datos[campo] = dato
        end
      end

      def subsidio_causado dato
        @datos["SubsidioAlEmpleo.SubsidioCausado"] = dato
      end

      def saldo dato
        @datos["CompensacionSaldosAFavor.SaldoAFavor"] = dato
      end

      def anio dato
        @datos["CompensacionSaldosAFavor.Año"] = dato
      end

      def remanente_saldo dato
        @datos["CompensacionSaldosAFavor.RemanenteSalFav"] = dato
      end

    end
  end
end
