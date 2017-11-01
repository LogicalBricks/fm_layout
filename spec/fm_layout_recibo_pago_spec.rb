# encoding: utf-8
require 'spec_helper'

describe 'DSL para generar el layout_recibo_pago de Facturación moderna' do
  context 'ReciboElectronicoPago' do
    context 'llenando todos los campos' do
      let(:hora) {Time.now.strftime("%FT%T")}
      let(:prueba) do
        # DSL
        FmLayout.define_layout_recibo_pago do |f|
          f.encabezado do |e|
            e.serie 'A'
            e.folio 10
            e.fecha hora
            e.numero_de_certificado '111222111'
            e.moneda 'MXN'
            e.tipo_de_comprobante 'P'
            e.lugar_de_expedicion '68000'
          end
          f.datos_adicionales do |d|
            d.tipo_de_documento 'Recibo electrónico de pago'
            d.observaciones 'Efectos Fiscales al Pago'
            d.id_transaccion 5
          end
          f.emisor do |e|
            e.rfc 'TUMG620310R95'
            e.nombre 'FACTURACION MODERNA S.A de C.V.'
            e.regimen_fiscal '612'
          end
          f.receptor do |r|
            r.rfc 'XAXX010101000'
            r.nombre 'PUBLICO EN GENERAL'
          end
          f.pago do |p|
            p.fecha_pago '2017-07-02T16:47:00'
            p.forma_de_pago '01'
            p.moneda 'MXN'
            p.monto '1800'
            p.numero_operacion '1'
            p.rfc_emisor_cuenta_ordenante 'XAXX010101000'
            p.nombre_banco_ordenante 'Banamex'
            p.numero_cuenta_ordenante '1234-1234-1234-1234'
            p.rfc_emisor_cuenta_beneficiario 'TUMG620310R95'
            p.numero_cuenta_beneficiario '4321-4321-4321-4321'
            p.tipo_cadena_pago 'tipo_cadena'
            p.cetificado_pago 'certificado'
            p.cadena_pago 'cadena'
            p.sello_pago 'sello'

            p.documento_relacionado do |dr|
              dr.id_documento "00000000-0000-0000-0000-000000000000"
              dr.serie 'RP'
              dr.folio '01'
              dr.moneda 'MXN'
              dr.tipo_cambio
              dr.metodo_pago 'PPD'
              dr.numero_parcialidad '1'
              dr.importe_saldo_anterior 2500
              dr.importe_pagado 2000
              dr.importe_saldo_insoluto 500
            end

            p.documento_relacionado do |dr|
              dr.id_documento "00000000-0000-0000-0000-000000000000"
              dr.serie 'RP'
              dr.folio '02'
              dr.moneda 'MXN'
              dr.tipo_cambio
              dr.metodo_pago 'PPD'
              dr.numero_parcialidad '01'
              dr.importe_saldo_anterior 3500
              dr.importe_pagado 500
              dr.importe_saldo_insoluto 3000
            end
          end
          f.pago do |p|
            p.fecha_pago '2017-07-02T16:47:00'
            p.forma_de_pago '01'
            p.moneda 'MXN'
            p.monto '1800'
            p.numero_operacion '1'
            p.rfc_emisor_cuenta_ordenante 'XAXX010101000'
            p.nombre_banco_ordenante 'Banamex'
            p.numero_cuenta_ordenante '1234-1234-1234-1234'
            p.rfc_emisor_cuenta_beneficiario 'TUMG620310R95'
            p.numero_cuenta_beneficiario '4321-4321-4321-4321'
            p.tipo_cadena_pago 'tipo_cadena'
            p.cetificado_pago 'certificado'
            p.cadena_pago 'cadena'
            p.sello_pago 'sello'

            p.documento_relacionado do |dr|
              dr.id_documento "00000000-0000-0000-0000-000000000000"
              dr.serie 'RP'
              dr.folio '01'
              dr.moneda 'MXN'
              dr.tipo_cambio
              dr.metodo_pago 'PPD'
              dr.numero_parcialidad '1'
              dr.importe_saldo_anterior 2500
              dr.importe_pagado 2000
              dr.importe_saldo_insoluto 500
            end
          end
        end
      end

      context 'recibo pagos' do
        let(:recibo_pagos){ prueba.to_h['ReciboPagos'] }
        it{ expect(recibo_pagos['Serie']).to eq('A') }
        it{ expect(recibo_pagos['Folio']).to eq(10) }
        it{ expect(recibo_pagos['Fecha']).to eq(hora) }
        it{ expect(recibo_pagos['NoCertificado']).to eq('111222111') }
        it{ expect(recibo_pagos['Moneda']).to eq('MXN') }
        it{ expect(recibo_pagos['TipoDeComprobante']).to eq('P') }
        it{ expect(recibo_pagos['LugarExpedicion']).to eq('68000') }
      end

      context 'datos adicionales' do
        let(:datos_adicionales){ prueba.to_h['DatosAdicionales'] }
        it{ expect(datos_adicionales['tipoDocumento']).to eq('Recibo electrónico de pago') }
        it{ expect(datos_adicionales['observaciones']).to eq('Efectos Fiscales al Pago') }
        it{ expect(datos_adicionales['TransID']).to eq(5) }
      end

      context 'emisor' do
        let(:emisor){ prueba.to_h['Emisor'] }
        it{ expect(emisor['Rfc']).to eq('TUMG620310R95') }
        it{ expect(emisor['Nombre']).to eq('FACTURACION MODERNA S.A de C.V.') }
        it{ expect(emisor['RegimenFiscal']).to eq('612') }
      end

      context 'receptor' do
        let(:receptor){ prueba.to_h['Receptor'] }
        it{ expect(receptor['Rfc']).to eq('XAXX010101000') }
        it{ expect(receptor['Nombre']).to eq('PUBLICO EN GENERAL') }
      end

      context "pago#1" do
        let(:pago){ prueba.to_h['Pagos'][0]['Pago#1'] }
        it { expect(pago['FechaPago']).to eq '2017-07-02T16:47:00' }
        it { expect(pago['FormaDePagoP']).to eq '01' }
        it { expect(pago['MonedaP']).to eq 'MXN' }
        it { expect(pago['Monto']).to eq '1800' }
        it { expect(pago['NumOperacion']).to eq '1' }
        it { expect(pago['RfcEmisorCtaOrd']).to eq 'XAXX010101000' }
        it { expect(pago['NomBancoOrdExt']).to eq 'Banamex' }
        it { expect(pago['CtaOrdenante']).to eq '1234-1234-1234-1234' }
        it { expect(pago['RfcEmisorCtaBen']).to eq 'TUMG620310R95' }
        it { expect(pago['CtaBeneficiario']).to eq '4321-4321-4321-4321' }
        it { expect(pago['TipoCadPago']).to eq 'tipo_cadena' }
        it { expect(pago['CertPago']).to eq 'certificado' }
        it { expect(pago['CadPago']).to eq 'cadena' }
        it { expect(pago['SelloPago']).to eq 'sello' }

        it { expect(pago['DoctoRelacionado.IdDocumento']).to eq '[00000000-0000-0000-0000-000000000000,00000000-0000-0000-0000-000000000000]' }
        it { expect(pago['DoctoRelacionado.Serie']).to eq '[RP,RP]' }
        it { expect(pago['DoctoRelacionado.Folio']).to eq '[01,02]' }
        it { expect(pago['DoctoRelacionado.MonedaDR']).to eq '[MXN,MXN]' }
        it { expect(pago['DoctoRelacionado.TipoCambioDR']).to eq '[,]' }
        it { expect(pago['DoctoRelacionado.MetodoDePagoDR']).to eq '[PPD,PPD]' }
        it { expect(pago['DoctoRelacionado.NumParcialidad']).to eq '[1,01]' }
        it { expect(pago['DoctoRelacionado.ImpSaldoAnt']).to eq '[2500,3500]' }
        it { expect(pago['DoctoRelacionado.ImpPagado']).to eq '[2000,500]' }
        it { expect(pago['DoctoRelacionado.ImpSaldoInsoluto']).to eq '[500,3000]' }
      end # context Pago1

      context "pago#2" do
        let(:pago){ prueba.to_h['Pagos'][1]['Pago#2'] }
        it { expect(pago['FechaPago']).to eq '2017-07-02T16:47:00' }
        it { expect(pago['FormaDePagoP']).to eq '01' }
        it { expect(pago['MonedaP']).to eq 'MXN' }
        it { expect(pago['Monto']).to eq '1800' }
        it { expect(pago['NumOperacion']).to eq '1' }
        it { expect(pago['RfcEmisorCtaOrd']).to eq 'XAXX010101000' }
        it { expect(pago['NomBancoOrdExt']).to eq 'Banamex' }
        it { expect(pago['CtaOrdenante']).to eq '1234-1234-1234-1234' }
        it { expect(pago['RfcEmisorCtaBen']).to eq 'TUMG620310R95' }
        it { expect(pago['CtaBeneficiario']).to eq '4321-4321-4321-4321' }
        it { expect(pago['TipoCadPago']).to eq 'tipo_cadena' }
        it { expect(pago['CertPago']).to eq 'certificado' }
        it { expect(pago['CadPago']).to eq 'cadena' }
        it { expect(pago['SelloPago']).to eq 'sello' }

        it { expect(pago['DoctoRelacionado.IdDocumento']).to eq '[00000000-0000-0000-0000-000000000000]' }
        it { expect(pago['DoctoRelacionado.Serie']).to eq '[RP]' }
        it { expect(pago['DoctoRelacionado.Folio']).to eq '[01]' }
        it { expect(pago['DoctoRelacionado.MonedaDR']).to eq '[MXN]' }
        it { expect(pago['DoctoRelacionado.TipoCambioDR']).to eq '[]' }
        it { expect(pago['DoctoRelacionado.MetodoDePagoDR']).to eq '[PPD]' }
        it { expect(pago['DoctoRelacionado.NumParcialidad']).to eq '[1]' }
        it { expect(pago['DoctoRelacionado.ImpSaldoAnt']).to eq '[2500]' }
        it { expect(pago['DoctoRelacionado.ImpPagado']).to eq '[2000]' }
        it { expect(pago['DoctoRelacionado.ImpSaldoInsoluto']).to eq '[500]' }
      end # context Pago1

      context 'salida en texto' do
        let(:salida){ prueba.to_s }
        it{ expect(salida).to match(/\[ReciboPagos\]/) }
        it{ expect(salida).to match(/\[DatosAdicionales\]/) }
        it{ expect(salida).to match(/\[Emisor\]/) }
        it{ expect(salida).to match(/\[Receptor\]/) }
        it{ expect(salida).to match(/\[Pago#1\]/) }
      end

    end

    context 'llenado sin campos' do
      let(:prueba) do
        # DSL
        FmLayout.define_layout_recibo_pago do |f|
          f.encabezado do |e|
          end
          f.datos_adicionales do |d|
            d.id_transaccion 5
          end
          f.emisor do |e|
          end
          f.receptor do |r|
          end
        end
      end

      context 'recibo pagos' do
        let(:encabezado){ prueba.to_h['ReciboPagos'] }
        it{ expect(encabezado['Fecha']).to be_nil }
        it{ expect(encabezado['Folio']).to be_nil }
        it{ expect(encabezado['NoCertificado']).to be_nil }
      end

      context 'datos adicionales' do
        let(:datos_adicionales){ prueba.to_h['DatosAdicionales'] }
        it{ expect(datos_adicionales['tipoDocumento']).to eq('Factura') }
      end

      context 'salida en texto' do
        let(:salida){ prueba.to_s }
        it{ expect(salida).to match(/\[ReciboPagos\]/) }
        it{ expect(salida).to match(/\[DatosAdicionales\]/) }
        it{ expect(salida).to match("TransID|5") }
        it{ expect(salida).to match(/\[Emisor\]/) }
        it{ expect(salida).to match(/\[Receptor\]/) }
      end
    end
  end
end
