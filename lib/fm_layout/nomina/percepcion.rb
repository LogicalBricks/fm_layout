module FmLayout
  module Nomina
    class Percepcion

      include ::FmLayout::FmSeccionNomina

      def initialize
        @titulo= 'Percepcion'
        @datos= {}
        @horas_extras_dias = []
        @horas_extras_tipo_horas = []
        @horas_extras_horas_extras = []
        @horas_extras_importe_pagado = []
        #valores_iniciales
      end

      def self.campos_vs_metodos
        {
          'TipoPercepcion' => 'tipo',
          'Clave'          => 'clave',
          'Concepto'       => 'concepto',
          'ImporteGravado' => 'importe_gravado',
          'ImporteExento'  => 'importe_exento',
        }
      end

      def horas_extra
        horas_extra = HorasExtra.new
        if block_given?
          yield(horas_extra)
          @horas_extras_dias << horas_extra.datos["Dias"]
          @horas_extras_tipo_horas << horas_extra.datos["TipoHoras"]
          @horas_extras_horas_extras << horas_extra.datos["HorasExtra"]
          @horas_extras_importe_pagado << horas_extra.datos["ImportePagado"]
          formato_horas_extras
        else
          horas_extra
        end
      end

      # Creación de los métodos de acceso dinámicamente
      campos_vs_metodos.each do |campo, metodo|
        define_method(metodo) do |dato|
          @datos[campo] = dato
        end
      end

      def formato_horas_extras
        @datos[:"HorasExtra.Dias"] = "[#{@horas_extras_dias.join(',')}]"
        @datos[:"HorasExtra.TipoHoras"] = "[#{@horas_extras_tipo_horas.join(',')}]"
        @datos[:"HorasExtra.HorasExtra"] = "[#{@horas_extras_horas_extras.join(',')}]"
        @datos[:"HorasExtra.ImportePagado"] = "[#{@horas_extras_importe_pagado.join(',')}]"
      end

      def valor_mercado dato
        @datos["AccionesOTitulos.ValorMercado"] = dato
      end

      def precio_al_otorgarse dato
        @datos["AccionesOTitulos.PrecioAlOtorgarse"] = dato
      end

    end
  end
end
