require 'fm_layout/fm_seccion'

module FmLayout
  class Estimacion
    include FmSeccion

    def initialize
      @titulo = 'Estimacion'
      @datos = {}
    end

    def self.campos_vs_metodos
      {
        'nombre'                => 'nombre',
        'importeEstimacion'     => 'importe_estimacion',
        'amortizacionAnticipo'  => 'amortizacion_anticipo',
        'retencion'             => 'retencion',
        'devolucion'            => 'devolucion',
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
