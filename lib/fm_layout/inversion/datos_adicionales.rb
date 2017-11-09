require 'fm_layout/inversion/fm_seccion'

module FmLayout
  module Inversion
    class DatosAdicionales
      include FmSeccion

      def initialize
        @titulo = "Datos Adicionales"
        @datos= {}
        valores_iniciales
      end

      def self.campos_vs_metodos
        {
          'tipoDocumento'       => 'tipo_de_documento',
          'numeropedido'        => 'numero_de_pedido',
          'observaciones'       => 'observaciones',
          'idNomina'            => 'id_de_nomina',
          'idTrabajador'        => 'id_de_trabajador',
          'leyenda'             => 'leyenda',
          'TransID'             => 'id_transaccion',
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
        @datos['tipoDocumento'] = 'Factura'
      end

    end
  end
end
