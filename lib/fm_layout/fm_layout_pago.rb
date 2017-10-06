require "fm_layout/fm_layout"
require "fm_layout/recibo_pago"
require "fm_layout/pago"

module FmLayout
  class FmLayoutPago < FmLayout
    def initialize
      super
      @encabezado = ReciboPago.new
      @pago = Pago.new
    end

    def pago
      yield(@pago) if block_given?
      @pago
    end

    def to_h
      super.merge(obtener_hash_pago)
    end

    def to_s
      salida = super
      salida += @pago.to_s
      salida
    end

    private

    def obtener_hash_pago
      {'Pago' => @pago.to_h }
    end
  end
end
