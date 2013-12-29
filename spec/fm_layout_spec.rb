require 'spec_helper'

describe 'DSL para generar el layout de Facturación moderna' do
  context 'factura' do
    context 'llenando todos los campos' do
      let(:hora) {Time.now.strftime("%FT%T")}
      let(:prueba) do
        # DSL
        FmLayout.define_layout do |f|
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
          f.domicilio_fiscal do |d|
            d.calle 'Calle 1'
            d.numero_exterior 'Número Exterior'
            d.numero_interior 'Número Interior'
            d.colonia 'Colonia'
            d.localidad 'Localidad'
            d.municipio 'Municipio'
            d.estado 'NUEVO LEON'
            d.pais 'México'
            d.codigo_postal '66260'
          end
f.expedido_en do |d|
            d.calle 'Calle 2'
            d.numero_exterior 'Número Exterior 2'
            d.numero_interior 'Número Interior 2'
            d.colonia 'Colonia 2'
            d.localidad 'Localidad 2'
            d.municipio 'Municipio 2'
            d.estado 'OAXACA'
            d.pais 'México'
            d.codigo_postal '68000'
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

      context 'domicilio fiscal' do
        it{ expect(prueba.to_h['DomicilioFiscal']['calle']).to eq('Calle 1') }
        it{ expect(prueba.to_h['DomicilioFiscal']['noExterior']).to eq('Número Exterior') }
        it{ expect(prueba.to_h['DomicilioFiscal']['noInterior']).to eq('Número Interior') }
        it{ expect(prueba.to_h['DomicilioFiscal']['colonia']).to eq('Colonia') }
        it{ expect(prueba.to_h['DomicilioFiscal']['localidad']).to eq('Localidad') }
        it{ expect(prueba.to_h['DomicilioFiscal']['municipio']).to eq('Municipio') }
        it{ expect(prueba.to_h['DomicilioFiscal']['estado']).to eq('NUEVO LEON') }
        it{ expect(prueba.to_h['DomicilioFiscal']['pais']).to eq('México') }
        it{ expect(prueba.to_h['DomicilioFiscal']['codigoPostal']).to eq('66260') }
      end

      context 'expedido en' do
        it{ expect(prueba.to_h['ExpedidoEn']['calle']).to eq('Calle 2') }
        it{ expect(prueba.to_h['ExpedidoEn']['noExterior']).to eq('Número Exterior 2') }
        it{ expect(prueba.to_h['ExpedidoEn']['noInterior']).to eq('Número Interior 2') }
        it{ expect(prueba.to_h['ExpedidoEn']['colonia']).to eq('Colonia 2') }
        it{ expect(prueba.to_h['ExpedidoEn']['localidad']).to eq('Localidad 2') }
        it{ expect(prueba.to_h['ExpedidoEn']['municipio']).to eq('Municipio 2') }
        it{ expect(prueba.to_h['ExpedidoEn']['estado']).to eq('OAXACA') }
        it{ expect(prueba.to_h['ExpedidoEn']['pais']).to eq('México') }
        it{ expect(prueba.to_h['ExpedidoEn']['codigoPostal']).to eq('68000') }
      end

    end
  end
end
