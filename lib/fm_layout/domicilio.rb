# encoding: utf-8
require 'fm_layout/inversion/fm_seccion'

module FmLayout
  class Domicilio
    include Inversion::FmSeccion

    def initialize(titulo = 'Domicilio', separador = '|')
      @separador = separador
      @titulo = titulo
      @datos = {}
      valores_iniciales
    end

    def self.campos_vs_metodos
      {
        'calle'           => 'calle',
        'noExterior'      => 'numero_exterior',
        'noInterior'      => 'numero_interior',
        'colonia'         => 'colonia',
        'localidad'       => 'localidad',
        'municipio'       => 'municipio',
        'estado'          => 'estado',
        'pais'            => 'pais',
        'codigoPostal'    => 'codigo_postal',
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
      @datos['pais'] = 'México'
    end
  end
end
