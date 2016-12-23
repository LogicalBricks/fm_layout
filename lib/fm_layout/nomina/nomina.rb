require 'fm_layout/nomina/complemento_nomina'
require 'fm_layout/nomina/percepcion'
require 'fm_layout/nomina/deduccion'
require 'fm_layout/nomina/incapacidad'
require 'fm_layout/nomina/horas_extra'
require 'fm_layout/nomina/jubilacion_pension_retiro'

module FmLayout
  module Nomina
    class Nomina

      def initialize
        @complemento_nomina = ComplementoNomina.new
        @percepciones =  []
        @jubilacion_pension_retiro = []
        @deducciones =  []
        @incapacidades =  []
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

      def jubilacion_pension_retiro
        jubilacion_pension_retiro = JubilacionPensionRetiro.new
        if block_given?
          yield(jubilacion_pension_retiro)
          @jubilacion_pension_retiro << jubilacion_pension_retiro
        else
          jubilacion_pension_retiro
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

      def to_h
        { 'Nomina' => {}.merge( @complemento_nomina.to_h).merge(obtener_hash_percepciones).merge(obtener_hash_jubilacion_pension_retiro).merge(obtener_hash_deducciones).merge(obtener_hash_incapacidades) }
      end

      def to_s
        @complemento_nomina.to_s + @percepciones.map(&:to_s).inject(:+).to_s + @jubilacion_pension_retiro.map(&:to_s).inject(:+).to_s + @deducciones.map(&:to_s).inject(:+).to_s + @incapacidades.map(&:to_s).inject(:+).to_s
      end

      private

      def obtener_hash_percepciones
        { 'Percepciones' => @percepciones.map(&:to_h) }
      end

      def obtener_hash_jubilacion_pension_retiro
        @jubilacion_pension_retiro.map(&:to_h).first
      end

      def obtener_hash_deducciones
        { 'Deducciones' => @deducciones.map(&:to_h) }
      end

      def obtener_hash_incapacidades
        { 'Incapacidades' => @incapacidades.map(&:to_h) }
      end

      def obtener_hash_horas_extra
        { 'InformacionHorasExtra' => @horas_extras.map(&:to_h) }
      end

    end
  end
end
