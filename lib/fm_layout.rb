require "fm_layout/version"
require "fm_layout/fm_layout"
require "fm_layout/fm_layout_nomina"
require "fm_layout/fm_layout_pago"
require "fm_layout/fm_layout_inversion"

module FmLayout
  def self.define_layout
    layout = FmLayout.new
    yield(layout) if block_given?
    layout
  end

  def self.define_layout_nomina
    layout = FmLayoutNomina.new
    yield(layout) if block_given?
    layout
  end

  def self.define_layout_recibo_pago
    layout = FmLayoutPago.new
    yield(layout) if block_given?
    layout
  end

  def self.define_layout_inversion
    layout = FmLayoutInversion.new
    yield(layout) if block_given?
    layout
  end
end

# Monkeypatch
if RUBY_VERSION < '2.0'
  class NilClass
    def to_h
      {}
    end
  end
end
