require 'fm_layout/fm_seccion'

module FmLayout
  class DocumentoRelacionado
    attr_reader :datos
    attr_accessor :arr_id_documento, :arr_serie, :arr_folio, :arr_moneda, :arr_tipo_cambio,
      :arr_metodo_pago, :arr_metodo_pago, :arr_num_parcialidad, :arr_imp_saldo_ant, :arr_imp_pagado,
      :arr_saldo_insoluto
    include FmSeccion

    def initialize
      @arr_id_documento    = []
      @arr_serie           = []
      @arr_folio           = []
      @arr_moneda          = []
      @arr_tipo_cambio     = []
      @arr_metodo_pago     = []
      @arr_num_parcialidad = []
      @arr_imp_saldo_ant   = []
      @arr_imp_pagado      = []
      @arr_saldo_insoluto  = []
      @datos = {}
    end

    def id_documento value
      arr_id_documento.push value
      @datos["IdDocumento"] = "[#{arr_id_documento.join(',')}]"
    end

    def serie value = ''
      arr_serie.push value
      @datos["Serie"] = "[#{arr_serie.join(',')}]"
    end

    def folio value = ''
      arr_folio.push value
      @datos["Folio"] = "[#{arr_folio.join(',')}]"
    end

    def moneda value
      arr_moneda.push value
      @datos["MonedaDR"] = "[#{arr_moneda.join(',')}]"
    end

    def tipo_cambio value = ''
      arr_tipo_cambio.push value
      @datos["TipoCambioDR"] = "[#{arr_tipo_cambio.join(',')}]"
    end

    def metodo_pago value
      arr_metodo_pago.push value
      @datos["MetodoDePagoDR"] = "[#{arr_metodo_pago.join(',')}]"
    end

    def numero_parcialidad value = ''
      arr_num_parcialidad.push value
      @datos["NumParcialidad"] = "[#{arr_num_parcialidad.join(',')}]"
    end

    def importe_saldo_anterior value = ''
      arr_imp_saldo_ant.push value
      @datos["ImpSaldoAnt"] = "[#{arr_imp_saldo_ant.join(',')}]"
    end

    def importe_pagado value = ''
      arr_imp_pagado.push value
      @datos["ImpPagado"] = "[#{arr_imp_pagado.join(',')}]"
    end

    def importe_saldo_insoluto value = ''
      arr_saldo_insoluto.push value
      @datos["ImpSaldoInsoluto"] = "[#{arr_saldo_insoluto.join(',')}]"
    end
  end
end
