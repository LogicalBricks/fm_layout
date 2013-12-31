require 'fm_layout/nomina/complemento_nomina'
require 'fm_layout/nomina/percepcion'
require 'fm_layout/nomina/deduccion'
require 'fm_layout/nomina/incapacidad'
require 'fm_layout/nomina/horas_extra'

module FmLayout
  module Nomina
    class Nomina

      def initialize
        @complemento_nomina = ComplementoNomina.new
        @percepciones =  []
        @deducciones =  []
        @incapacidades =  []
        @horas_extras =  []
      end

      def complemento_nomina
        if block_given?
          yield(@complemento_nomina)
        else
          @complemento_nomina
        end
      end

      def percepcion
        percepcion = Percepcion.new
        if block_given?
          yield(percepcion)
          @percepciones << percepcion
        else
          percepcion
        end
      end

      def deduccion
        deduccion = Deduccion.new
        if block_given?
          yield(deduccion)
          @deducciones << deduccion
        else
          deduccion
        end
      end

      def incapacidad
        incapacidad = Incapacidad.new
        if block_given?
          yield(incapacidad)
          @incapacidades << incapacidad
        else
          incapacidad
        end
      end

      def horas_extra
        horas_extra = HorasExtra.new
        if block_given?
          yield(horas_extra)
          @horas_extras << horas_extra
        else
          horas_extra
        end
      end


      def to_h
        hash = {}
        hash.merge!({ @complemento_nomina.titulo => @complemento_nomina.to_h}) if @complemento_nomina
        hash.merge!(obtener_hash_percepciones)
        hash.merge!(obtener_hash_deducciones)
        hash.merge!(obtener_hash_incapacidades)
        hash.merge!(obtener_hash_horas_extra)
        hash
      end

      def to_s
        salida = @complemento_nomina.to_s
        @percepciones.each do |d|
          salida += d.to_s
        end
        @deducciones.each do |d|
          salida += d.to_s
        end
        @incapacidades.each do |d|
          salida += d.to_s
        end
        @horas_extras.each do |d|
          salida += d.to_s
        end
        salida
      end

      private

      def obtener_hash_percepciones
        percepciones = {}
        percepciones['Percepciones'] = []
        @percepciones.each do |c|
          percepciones['Percepciones'] << { c.titulo => c.to_h }
        end
        percepciones
      end

      def obtener_hash_deducciones
        deducciones = {}
        deducciones['Deducciones'] = []
        @deducciones.each do |c|
          deducciones['Deducciones'] << { c.titulo => c.to_h }
        end
        deducciones
      end

      def obtener_hash_incapacidades
        incapacidades = {}
        incapacidades['Incapacidades'] = []
        @incapacidades.each do |c|
          incapacidades['Incapacidades'] << { c.titulo => c.to_h }
        end
        incapacidades
      end

      def obtener_hash_horas_extra
        horas_extra = {}
        horas_extra['InformacionHorasExtra'] = []
        @horas_extras.each do |c|
          horas_extra['InformacionHorasExtra'] << { c.titulo => c.to_h }
        end
        horas_extra
      end

    end
  end
end
