class FmLayoutEncabezado
  def initialize
    @encabezado = {}
    valores_iniciales
  end

  def self.campos_vs_metodos
    {
      'serie'               => 'serie',
      'fecha'               => 'fecha',
      'folio'               => 'folio',
      'tipoDeComprobante'   => 'tipo_de_comprobante',
      'formaDePago'         => 'forma_de_pago',
      'metodoDePago'        => 'metodo_de_pago',
      'condicionesDePago'   => 'condiciones_de_pago',
      'NumCtaPago'          => 'numero_de_cuenta_de_pago',
      'subTotal'            => 'subtotal',
      'descuento'           => 'descuento',
      'total'               => 'total',
      'Moneda'              => 'moneda',
      'TipoCambio'          => 'tipo_de_cambio',
      'noCertificado'       => 'numero_de_certificado',
      'LugarExpedicion'     => 'lugar_de_expedicion'
    }
  end

  # Creación de los métodos de acceso dinámicamente
  campos_vs_metodos.each do |campo, metodo|
    define_method(metodo) do |dato|
      @encabezado[campo] = dato
    end
  end

  def to_h
    @encabezado
  end

  def to_s
    salida = "[Encabezado]\r\n\r\n"
    @encabezado.each do |k,v|
      salida += "#{k}|#{v}\r\n"
    end
    salida
  end

  private

  def valores_iniciales
    @encabezado['fecha'] = 'asignarFecha'
    @encabezado['folio'] = 'asignarFolio'
  end
end

class FmLayoutDatosAdicionales
  def initialize
    @datos_adicionales = {}
  end

  def self.campos_vs_metodos
    {
      'tipoDocumento'       => 'tipo_de_documento',
      'numeropedido'        => 'numero_de_pedido',
      'observaciones'       => 'observaciones',
    }
  end

  # Creación de los métodos de acceso dinámicamente
  campos_vs_metodos.each do |campo, metodo|
    define_method(metodo) do |dato|
      @datos_adicionales[campo] = dato
    end
  end

  def to_h
    @datos_adicionales
  end

  def to_s
    salida = "[Datos Adicionales]\r\n\r\n"
    @datos_adicionales.each do |k,v|
      salida += "#{k}|#{v}\r\n"
    end
    salida
  end
end

class FmLayoutEmisor
  def initialize
    @emisor = {}
  end

  def self.campos_vs_metodos
    {
      'rfc'           => 'rfc',
      'nombre'        => 'nombre',
      'RegimenFiscal' => 'regimen_fiscal',
    }
  end

  # Creación de los métodos de acceso dinámicamente
  campos_vs_metodos.each do |campo, metodo|
    define_method(metodo) do |dato|
      @emisor[campo] = dato
    end
  end

  def to_h
    @emisor
  end

  def to_s
    salida = "[Emisor]\r\n\r\n"
    @emisor.each do |k,v|
      salida += "#{k}|#{v}\r\n"
    end
    salida
  end
end

class FmLayout
  def initialize
    @encabezado = FmLayoutEncabezado.new
    @datos_adicionales = FmLayoutDatosAdicionales.new
    @emisor = FmLayoutEmisor.new
  end

  def encabezado
    if block_given?
      yield(@encabezado)
    else
      @encabezado
    end
  end

  def datos_adicionales
    if block_given?
      yield(@datos_adicionales)
    else
      @datos_adicionales
    end
  end

  def emisor
    if block_given?
      yield(@emisor)
    else
      @emisor
    end
  end

  def to_s
    @encabezado.to_s +
      @datos_adicionales.to_s +
      @emisor.to_s
  end

  def to_h
    { 'Encabezado' => @encabezado.to_h,
      'Datos Adicionales' => @datos_adicionales.to_h,
      'Emisor' => @emisor.to_h
    }
  end
end



def fm_define_layout
  layout = FmLayout.new
  yield(layout) if block_given?
  layout
end

describe 'DSL para generar el layout de Facturación moderna' do
  context 'factura' do
    context 'llenando todos los campos' do
      let(:hora) {Time.now.strftime("%FT%T")}
      let(:prueba) do
        # DSL
        fm_define_layout do |f|
          f.encabezado do |e|
            e.serie 'A'
            e.folio 10
            e.fecha hora
            e.tipo_de_comprobante 'ingreso'
            e.forma_de_pago 'PAGO EN UNA SOLA EXHIBICIÓN'
            e.metodo_de_pago 'Transferencia Electrónica'
            e.condiciones_de_pago 'Contado'
            e.numero_de_cuenta_de_pago '0098-HSBC'
            e.subtotal 100.00
            e.descuento 0.00
            e.total 116.00
            e.moneda 'MXN'
            e.tipo_de_cambio 1.0
            e.numero_de_certificado '111222111'
            e.lugar_de_expedicion 'Nuevo León, México'
          end
          f.datos_adicionales do |d|
            d.tipo_de_documento 'Factura'
            d.numero_de_pedido '123456'
            d.observaciones 'Efectos Fiscales al Pago'
          end
          f.emisor do |e|
            e.rfc 'TUMG620310R95'
            e.nombre 'FACTURACION MODERNA S.A de C.V.'
            e.regimen_fiscal 'REGIMEN GENERAL DE LEY PERSONAS MORALES'
          end
        end
      end

      context 'encabezado' do
        it{ expect(prueba.to_h['Encabezado']['serie']).to eq('A') }
        it{ expect(prueba.to_h['Encabezado']['folio']).to eq(10) }
        it{ expect(prueba.to_h['Encabezado']['fecha']).to eq(hora) }
        it{ expect(prueba.to_h['Encabezado']['tipoDeComprobante']).to eq('ingreso') }
        it{ expect(prueba.to_h['Encabezado']['formaDePago']).to eq('PAGO EN UNA SOLA EXHIBICIÓN') }
        it{ expect(prueba.to_h['Encabezado']['condicionesDePago']).to eq('Contado') }
        it{ expect(prueba.to_h['Encabezado']['subTotal']).to eq(100.00) }
        it{ expect(prueba.to_h['Encabezado']['descuento']).to eq(0.00) }
        it{ expect(prueba.to_h['Encabezado']['total']).to eq(116.00) }
        it{ expect(prueba.to_h['Encabezado']['Moneda']).to eq('MXN') }
        it{ expect(prueba.to_h['Encabezado']['TipoCambio']).to eq(1.0) }
        it{ expect(prueba.to_h['Encabezado']['noCertificado']).to eq('111222111') }
        it{ expect(prueba.to_h['Encabezado']['LugarExpedicion']).to eq('Nuevo León, México') }
      end

      context 'datos adicionales' do
        it{ expect(prueba.to_h['Datos Adicionales']['tipoDocumento']).to eq('Factura') }
        it{ expect(prueba.to_h['Datos Adicionales']['numeropedido']).to eq('123456') }
        it{ expect(prueba.to_h['Datos Adicionales']['observaciones']).to eq('Efectos Fiscales al Pago') }
      end

      context 'emisor' do
        it{ expect(prueba.to_h['Emisor']['rfc']).to eq('TUMG620310R95') }
        it{ expect(prueba.to_h['Emisor']['nombre']).to eq('FACTURACION MODERNA S.A de C.V.') }
        it{ expect(prueba.to_h['Emisor']['RegimenFiscal']).to eq('REGIMEN GENERAL DE LEY PERSONAS MORALES') }
      end

    end
  end
end
