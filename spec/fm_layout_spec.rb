# encoding: utf-8
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
            e.forma_de_pago '01'
            e.numero_de_certificado '111222111'
            e.condiciones_de_pago 'Contado'
            e.subtotal 100.00
            e.descuento 0.00
            e.moneda 'MXN'
            e.total 116.00
            e.tipo_de_comprobante 'I'
            e.metodo_de_pago 'PUE'
            e.lugar_de_expedicion '68000'
          end

          f.informacion_global do |e|
            e.periodicidad '01'
            e.meses '01'
            e.anio '2022'
          end

          f.cfdi_relacionados do |cfdi|
            cfdi.tipo_relacion '04'
            cfdi.uuids "FCA37E7F-80FF-4CAE-9A03-37E095233F23,6424C23D-77B7-4F13-AD01-8CA0092D9623"
          end

          f.datos_adicionales do |d|
            d.tipo_de_documento 'Factura'
            d.observaciones 'Efectos Fiscales al Pago'
            d.id_transaccion 5
          end

          f.emisor do |e|
            e.rfc 'XIA190128J61'
            e.nombre 'FACTURACION MODERNA S.A de C.V.'
            e.regimen_fiscal '612'
            e.fac_atr_adquirente '0123456789'
          end

          f.receptor do |r|
            r.rfc 'XAXX010101000'
            r.nombre 'PUBLICO EN GENERAL'
            r.uso_cfdi 'G03'
            r.domicilio_fiscal '71243'
            r.regimen_fiscal '616'
          end

          f.concepto do |c|
            c.clave_producto_servicio '01010101'
            c.numero_de_identificacion '111222333'
            c.cantidad 1
            c.clave_unidad 'H87'
            c.unidad 'No Aplica'
            c.descripcion 'Caja Hojas Blancas Tamaño Carta'
            c.valor_unitario 110.00
            c.importe 110.00
            c.descuento 10.00
            c.objeto_imp '02'
            #c.cuenta_predial '123-132123'

            c.partes do |c|
              c.clave_producto_servicio '01010101'
              c.numero_de_identificacion '112233'
              c.cantidad  1
              c.unidad  'No aplica'
              c.descripcion 'Una descripcion'
            end

            c.partes do |c|
              c.clave_producto_servicio '01010101'
              c.numero_de_identificacion '112234'
              c.cantidad  1
              c.unidad  'No aplica'
              c.descripcion 'Otra descripcion'
            end

            c.impuesto_trasladado do |i|
              i.base 100.00
              i.impuesto '002'
              i.tipo_factor 'Tasa'
              i.tasa_o_cuota 0.16
              i.importe 16
            end

            c.impuesto_retenido do |i|
              i.base 100.00
              i.impuesto '001'
              i.tipo_factor 'Tasa'
              i.tasa_o_cuota 0.2
              i.importe 20
            end
          end

          f.concepto do |c|
            c.clave_producto_servicio '10101502'
            c.numero_de_identificacion '111222334'
            c.cantidad 2
            c.clave_unidad 'H87'
            c.unidad 'No Aplica'
            c.descripcion 'Plástico para forrar libros'
            c.valor_unitario 10.0
            c.importe 20.0

            c.impuesto_trasladado do |i|
              i.base 20.0
              i.impuesto '002'
              i.tipo_factor 'Tasa'
              i.tasa_o_cuota 0.16
              i.importe 3.2
            end

            c.impuesto_retenido do |i|
              i.base 20.0
              i.impuesto '001'
              i.tipo_factor 'Tasa'
              i.tasa_o_cuota 0.2
              i.importe 4
            end
          end

          f.impuesto_trasladado do |i|
            i.total_impuestos 19.2
            i.impuesto "002"
            i.tipo_factor "Tasa"
            i.tasa_o_cuota 0.16
            i.importe  19.2
            i.base 120
          end

          f.impuesto_trasladado_local do |i|
            i.impuesto 'ISH'
            i.importe  110.0
            i.tasa 0.11
          end

          f.impuesto_retenido do |i|
            i.total_impuestos 24
            i.impuesto "001"
            i.importe  24
          end

          f.impuesto_retenido_local do |i|
            i.impuesto 'IVA LOCAL'
            i.importe 110.00
            i.tasa 0.16
          end

          f.impuesto_retenido_local do |i|
            i.impuesto 'ISR LOCAL'
            i.importe 110.00
            i.tasa 0.16
          end

          f.complemento_ine do |i|
            i.tipo_proceso 'Ordinario'
            i.tipo_comite  'Ejecutivo Estatal'
          end

          f.entidad_ine do |e|
            e.clave_entidad  'OAX'
            e.id_contabilidad '000516'
          end
        end
      end

      context 'comprobante fiscal digital' do
        let(:comprobante_fiscal_digital){ prueba.to_h['ComprobanteFiscalDigital'] }
        it{ expect(comprobante_fiscal_digital['Version']).to eq('4.0') }
        it{ expect(comprobante_fiscal_digital['Serie']).to eq('A') }
        it{ expect(comprobante_fiscal_digital['Folio']).to eq(10) }
        it{ expect(comprobante_fiscal_digital['Fecha']).to eq(hora) }
        it{ expect(comprobante_fiscal_digital['FormaPago']).to eq('01') }
        it{ expect(comprobante_fiscal_digital['NoCertificado']).to eq('111222111') }
        it{ expect(comprobante_fiscal_digital['CondicionesDePago']).to eq('Contado') }
        it{ expect(comprobante_fiscal_digital['SubTotal']).to eq(100.00) }
        it{ expect(comprobante_fiscal_digital['Descuento']).to eq(0.00) }
        it{ expect(comprobante_fiscal_digital['Total']).to eq(116.00) }
        it{ expect(comprobante_fiscal_digital['Moneda']).to eq('MXN') }
        it{ expect(comprobante_fiscal_digital['TipoDeComprobante']).to eq('I') }
        it{ expect(comprobante_fiscal_digital['MetodoPago']).to eq('PUE') }
        it{ expect(comprobante_fiscal_digital['LugarExpedicion']).to eq('68000') }
        it{ expect(comprobante_fiscal_digital['Exportacion']).to eq('01') }
      end

      context 'informacion global' do
        let(:informacion_global){ prueba.to_h['InformacionGlobal'] }
        it{ expect(informacion_global['Periodicidad']).to eq('01') }
        it{ expect(informacion_global['Meses']).to eq('01') }
        it{ expect(informacion_global['Año']).to eq('2022') }
      end

      context "cfdi relacionados" do
        let(:cfdi_relacionado) { prueba.to_h['CfdiRelacionados'] }
        it{ expect(cfdi_relacionado['TipoRelacion']).to eq('04') }
        it{ expect(cfdi_relacionado['UUID']).to eq('[FCA37E7F-80FF-4CAE-9A03-37E095233F23,6424C23D-77B7-4F13-AD01-8CA0092D9623]') }
      end # context cfdi relacionados

      context 'datos adicionales' do
        let(:datos_adicionales){ prueba.to_h['DatosAdicionales'] }
        it{ expect(datos_adicionales['tipoDocumento']).to eq('Factura') }
        it{ expect(datos_adicionales['observaciones']).to eq('Efectos Fiscales al Pago') }
        it{ expect(datos_adicionales['TransID']).to eq(5) }
      end

      context 'emisor' do
        let(:emisor){ prueba.to_h['Emisor'] }
        it{ expect(emisor['Rfc']).to eq('XIA190128J61') }
        it{ expect(emisor['Nombre']).to eq('FACTURACION MODERNA S.A de C.V.') }
        it{ expect(emisor['RegimenFiscal']).to eq('612') }
        it{ expect(emisor['FacAtrAdquirente']).to eq('0123456789') }
      end

      context 'receptor' do
        let(:receptor){ prueba.to_h['Receptor'] }
        it{ expect(receptor['Rfc']).to eq('XAXX010101000') }
        it{ expect(receptor['UsoCFDI']).to eq('G03') }
        it{ expect(receptor['Nombre']).to eq('PUBLICO EN GENERAL') }
        it{ expect(receptor['DomicilioFiscalReceptor']).to eq('71243') }
        it{ expect(receptor['RegimenFiscalReceptor']).to eq('616') }
      end

      context 'primer concepto' do
        let(:concepto){ prueba.to_h['Conceptos'].first['Concepto#1'] }
        it{ expect(concepto['ClaveProdServ']).to eq('01010101') }
        it{ expect(concepto['NoIdentificacion']).to eq('111222333') }
        it{ expect(concepto['Cantidad']).to eq(1) }
        it{ expect(concepto['ClaveUnidad']).to eq('H87') }
        it{ expect(concepto['Unidad']).to eq('No Aplica') }
        it{ expect(concepto['Descripcion']).to eq('Caja Hojas Blancas Tamaño Carta') }
        it{ expect(concepto['ValorUnitario']).to eq(110.00) }
        it{ expect(concepto['Importe']).to eq(110.00) }
        it{ expect(concepto['Descuento']).to eq(10.00) }

        it{ expect(concepto['Parte.ClaveProdServ']).to eq("[01010101,01010101]") }
        it{ expect(concepto['Parte.NoIdentificacion']).to eq("[112233,112234]") }
        it{ expect(concepto['Parte.Cantidad']).to eq("[1,1]") }
        it{ expect(concepto['Parte.Unidad']).to eq("[No aplica,No aplica]") }
        it{ expect(concepto['Parte.Descripcion']).to eq("[Una descripcion,Otra descripcion]") }

        it{ expect(concepto['Impuestos.Traslados.Base']).to eq("[100.0]") }
        it{ expect(concepto['Impuestos.Traslados.Impuesto']).to eq("[002]") }
        it{ expect(concepto['Impuestos.Traslados.TipoFactor']).to eq("[Tasa]") }
        it{ expect(concepto['Impuestos.Traslados.TasaOCuota']).to eq("[0.16]") }
        it{ expect(concepto['Impuestos.Traslados.Importe']).to eq("[16]") }

        it{ expect(concepto['Impuestos.Retenciones.Base']).to eq("[100.0]") }
        it{ expect(concepto['Impuestos.Retenciones.Impuesto']).to eq("[001]") }
        it{ expect(concepto['Impuestos.Retenciones.TipoFactor']).to eq("[Tasa]") }
        it{ expect(concepto['Impuestos.Retenciones.TasaOCuota']).to eq("[0.2]") }
        it{ expect(concepto['Impuestos.Retenciones.Importe']).to eq("[20]") }
        #it{ expect(concepto['CuentaPredial']).to eq('123-132123') }
      end

      context 'segundo concepto' do
        let(:concepto){ prueba.to_h['Conceptos'].last['Concepto#2'] }
        it{ expect(concepto['ClaveProdServ']).to eq('10101502') }
        it{ expect(concepto['NoIdentificacion']).to eq('111222334') }
        it{ expect(concepto['Cantidad']).to eq(2) }
        it{ expect(concepto['ClaveUnidad']).to eq('H87') }
        it{ expect(concepto['Unidad']).to eq('No Aplica') }
        it{ expect(concepto['Descripcion']).to eq('Plástico para forrar libros') }
        it{ expect(concepto['ValorUnitario']).to eq(10.00) }
        it{ expect(concepto['Importe']).to eq(20.00) }

        it{ expect(concepto['Impuestos.Traslados.Base']).to eq("[20.0]") }
        it{ expect(concepto['Impuestos.Traslados.Impuesto']).to eq("[002]") }
        it{ expect(concepto['Impuestos.Traslados.TipoFactor']).to eq("[Tasa]") }
        it{ expect(concepto['Impuestos.Traslados.TasaOCuota']).to eq("[0.16]") }
        it{ expect(concepto['Impuestos.Traslados.Importe']).to eq("[3.2]") }

        it{ expect(concepto['Impuestos.Retenciones.Base']).to eq("[20.0]") }
        it{ expect(concepto['Impuestos.Retenciones.Impuesto']).to eq("[001]") }
        it{ expect(concepto['Impuestos.Retenciones.TipoFactor']).to eq("[Tasa]") }
        it{ expect(concepto['Impuestos.Retenciones.TasaOCuota']).to eq("[0.2]") }
        it{ expect(concepto['Impuestos.Retenciones.Importe']).to eq("[4]") }
      end

      context 'impuestos trasladados' do
        let(:traslado){ prueba.to_h['ImpuestosTrasladados']['Traslados'] }
        it{ expect(traslado['TotalImpuestosTrasladados']).to eq(19.2) }
        it{ expect(traslado['Impuesto']).to eq('[002]') }
        it{ expect(traslado['TasaOCuota']).to eq("[0.16]") }
        it{ expect(traslado['Importe']).to eq("[19.2]") }
      end

      context 'impuestos retenidos' do
        let(:retencion){ prueba.to_h['ImpuestosRetenidos']['Retenciones'] }
        it{ expect(retencion['TotalImpuestosRetenidos']).to eq(24) }
        it{ expect(retencion['Impuesto']).to eq("[001]") }
        it{ expect(retencion['Importe']).to eq("[24]") }
      end

      context 'impuestos trasladados locales' do
        let(:traslado_local){ prueba.to_h['ImpuestosTrasladadosLocales']['TrasladosLocales'] }
        it{ expect(traslado_local['ImpLocTrasladado']).to eq('[ISH]') }
        it{ expect(traslado_local['TasadeTraslado']).to eq("[0.11]") }
        it{ expect(traslado_local['Importe']).to eq("[110.0]") }
      end

      context 'impuestos retenidos locales' do
        let(:retencion_local){ prueba.to_h['ImpuestosRetenidosLocales']['RetencionesLocales'] }
        it{ expect(retencion_local['ImpLocRetenido']).to eq('[IVA LOCAL,ISR LOCAL]') }
        it{ expect(retencion_local['TasadeRetencion']).to eq("[0.16,0.16]") }
        it{ expect(retencion_local['Importe']).to eq("[110.0,110.0]") }
      end

      context 'ComplementoINE' do
        let(:complementoINE){ prueba.to_h['ComplementoINE'] }
        it{ expect(complementoINE['TipoProceso']).to eq('Ordinario') }
        it{ expect(complementoINE['TipoComite']).to eq('Ejecutivo Estatal') }
      end

      context 'ComplementoINE' do
        let(:entidadesINE){ prueba.to_h['EntidadesINE'].first['Entidad'] }
        it{ expect(entidadesINE['ClaveEntidad']).to eq('OAX') }
        it{ expect(entidadesINE['IdContabilidad']).to eq('000516') }
      end

      context 'salida en texto' do
        let(:salida){ prueba.to_s }
        it{ expect(salida).to match(/\[ComprobanteFiscalDigital\]/) }
        it{ expect(salida).to match(/\[InformacionGlobal\]/) }
        it{ expect(salida).to match(/\[DatosAdicionales\]/) }
        it{ expect(salida).to match(/\[Emisor\]/) }
        it{ expect(salida).to match(/\[Receptor\]/) }
        it{ expect(salida).to match(/\[Concepto#1\]/) }
        it{ expect(salida).to match(/\[Concepto#2\]/) }
        it{ expect(salida).to match(/\[Traslados\]/) }
        it{ expect(salida).to match(/\[Retenciones\]/) }
        it{ expect(salida).to match(/\[TrasladosLocales\]/) }
        it{ expect(salida).to match(/\[RetencionesLocales\]/) }
        it{ expect(salida).to match(/\[ComplementoINE\]/) }
        it{ expect(salida).to match(/\[Entidad\]/) }
      end

      context 'put file' do
        it {
          file = File.open('template.txt', 'w')
          file.write(prueba)
          file.close
        }
      end
    end

    context 'llenado sin campos' do
      let(:prueba) do
        # DSL
        FmLayout.define_layout do |f|
          f.encabezado do |e|
          end

          f.datos_adicionales do |d|
            d.id_transaccion 5
          end

          f.emisor do |e|
          end

          f.receptor do |r|
          end

          f.concepto do |c|
          end

          f.impuesto_trasladado do |i|
          end

          f.impuesto_retenido do |i|
          end
        end
      end

      context 'encabezado' do
        let(:encabezado) { prueba.to_h['ComprobanteFiscalDigital'] }
        it{ expect(encabezado['Version']).to eq('4.0') }
      end

      context 'datos adicionales' do
        let(:datos_adicionales) { prueba.to_h['DatosAdicionales'] }
        it{ expect(datos_adicionales['tipoDocumento']).to eq('Factura') }
      end

      context 'primer concepto' do
        let(:concepto) { prueba.to_h['Conceptos'].first['Concepto#1'] }
        it{ expect(concepto['Cantidad']).to eq(1) }
      end

      context 'salida en texto' do
        let(:salida) { prueba.to_s }
        it{ expect(salida).to match(/\[ComprobanteFiscalDigital\]/) }
        it{ expect(salida).to match(/\[DatosAdicionales\]/) }
        it{ expect(salida).to match("TransID|5") }
        it{ expect(salida).to match(/\[Emisor\]/) }
        it{ expect(salida).not_to match(/\[DomicilioFiscal\]/) }
        it{ expect(salida).not_to match(/\[ExpedidoEn\]/) }
        it{ expect(salida).to match(/\[Receptor\]/) }
        it{ expect(salida).to match(/\[Concepto#1\]/) }
      end

    end
  end
end
