require "fm_layout/version"
require "fm_layout/fm_layout"

module FmLayout
  def self.define_layout
    layout = FmLayout.new
    yield(layout) if block_given?
    layout
  end
end
