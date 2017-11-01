require "fm_layout/fm_layout"
require "fm_layout/recibo_pago"
require "fm_layout/pago"

module FmLayout
  class FmLayoutPago < FmLayout
    def initialize
      super
      @encabezado = ReciboPago.new
      @pagos = []
      @num_pago = 0
    end

    def pago
      @num_pago += 1
      pago = Pago.new @num_pago
      if block_given?
        yield(pago) if block_given?
        @pagos << pago
      else
        pago
      end
    end

    def to_h
      super.merge(obtener_hash_pago)
    end

    def to_s
      salida = super
      salida += @pagos.map(&:to_s).reduce(:+).to_s
      salida
    end

    private

    def obtener_hash_pago
      { 'Pagos' => @pagos.map(&:to_h) }
    end
  end
end
