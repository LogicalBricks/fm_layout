# encoding: utf-8
require 'spec_helper'

describe 'DSL para generar el layout de Facturación Moderna para nómina' do
  context 'nómina' do
    context 'llenando todos los campos' do
      let(:hoy){ Date.today }
      let(:inicio_quincena){ Date.today - 15 }
      let(:fin_quincena){ Date.today }
      let(:inicio_relacion_laboral){ Date.today - 48 * 7 }
      let(:prueba) do
        # DSL
        FmLayout.define_layout do |f|
          f.encabezado do |e|
            e.tipo_de_comprobante 'egreso'
            e.forma_de_pago 'PAGO EN UNA SOLA EXHIBICIÓN'
            e.metodo_de_pago 'Transferencia Electrónica'
            e.condiciones_de_pago 'Contado'
            e.motivo_de_descuento 'Deducciones de nómina'
            e.lugar_de_expedicion 'Nuevo León, México'
          end

          f.datos_adicionales do |d|
            d.tipo_de_documento 'RECIBO DE NOMINA'
            d.id_de_nomina 'N-1'
            d.id_de_trabajador ''
            d.leyenda 'Leyenda al pie del recibo'
          end

          f.emisor do |e|
            e.rfc 'ESI920427886'
            e.nombre 'FACTURACION MODERNA S.A de C.V.'
            e.regimen_fiscal 'REGIMEN GENERAL DE LEY PERSONAS MORALES'
          end

          f.receptor do |r|
            r.rfc 'XAXX010101000'
            r.nombre 'RAMIREZ MARTINEZ JUAN JOSE'
          end

          f.concepto do |c|
            c.unidad 'Servicio'
            c.descripcion 'Pago de Nómina'
            c.valor_unitario 3100.00
            c.importe 3100.00
          end

          f.nomina do |n|
            n.complemento_nomina do |c|
              c.registro_patronal 'P123456789'
              c.numero_de_empleado '2013001'
              c.curp 'XEXX010101MOCNRR02'
              c.tipo_de_regimen 1
              c.numero_de_seguridad_social '12345678912'
              c.fecha_de_pago hoy.strftime("%F")
              c.fecha_inicial_de_pago inicio_quincena.strftime("%F")
              c.fecha_final_de_pago fin_quincena.strftime("%F")
              c.dias_pagados 15
              c.departamento 'Desarrollo'
              c.clabe '123456789012345678'
              c.banco '012'
              c.inicio_de_relacion_laboral inicio_relacion_laboral.strftime("%F")
              c.antiguedad 48
              c.puesto 'Programador'
              c.tipo_de_contrato 'Base'
              c.tipo_de_jornada 'Mixta'
              c.periodicidad_de_pago 'Quincenal'
              c.salario_base 200
              c.riesgo_del_puesto 5
              c.salario_diario_integrado 209.04
            end

            n.percepcion do |p|
              p.tipo '001'
              p.clave '001'
              p.concepto 'Sueldos'
              p.importe_gravado 3000
              p.importe_exento 0
            end

            n.percepcion do |p|
              p.tipo '019'
              p.clave '019'
              p.concepto 'Horas extra'
              p.importe_gravado 0.0
              p.importe_exento 100.0
            end

            n.deduccion do |d|
              d.tipo '002'
              d.clave '001'
              d.concepto 'ISR'
              d.importe 0.0
            end

            n.deduccion do |d|
              d.tipo '001'
              d.clave '002'
              d.concepto 'IMSS'
              d.importe 0.0
            end

            n.deduccion do |d|
              d.tipo '006'
              d.clave '006'
              d.concepto 'Descuento por incapacidad'
              d.importe 0.0
            end

            n.incapacidad do |i|
              i.dias 1
              i.tipo 2
              i.importe_monetario 200.00
            end

            n.horas_extra do |h|
              h.dias 1
              h.tipo 'Dobles'
              h.horas_extra 1
              h.importe 100.00
            end
          end
        end
      end

      context 'encabezado' do
        let(:encabezado){ prueba.to_h['Encabezado'] }

        it{ expect(encabezado['fecha']).to eq('asignarFecha') }
        it{ expect(encabezado['tipoDeComprobante']).to eq('egreso') }
        it{ expect(encabezado['formaDePago']).to eq('PAGO EN UNA SOLA EXHIBICIÓN') }
        it{ expect(encabezado['condicionesDePago']).to eq('Contado') }
        it{ expect(encabezado['motivoDescuento']).to eq('Deducciones de nómina') }
        it{ expect(encabezado['LugarExpedicion']).to eq('Nuevo León, México') }
      end

      context 'datos adicionales' do
        let(:datos_adicionales){ prueba.to_h['Datos Adicionales'] }

        it{ expect(datos_adicionales['tipoDocumento']).to eq('RECIBO DE NOMINA') }
        it{ expect(datos_adicionales['idNomina']).to eq('N-1') }
        it{ expect(datos_adicionales['idTrabajador']).to eq('') }
        it{ expect(datos_adicionales['leyenda']).to eq('Leyenda al pie del recibo') }
      end

      context 'emisor' do
        let(:emisor){ prueba.to_h['Emisor'] }

        it{ expect(emisor['rfc']).to eq('ESI920427886') }
        it{ expect(emisor['nombre']).to eq('FACTURACION MODERNA S.A de C.V.') }
        it{ expect(emisor['RegimenFiscal']).to eq('REGIMEN GENERAL DE LEY PERSONAS MORALES') }
      end

      context 'receptor' do
        let(:receptor){ prueba.to_h['Receptor'] }

        it{ expect(receptor['rfc']).to eq('XAXX010101000') }
        it{ expect(receptor['nombre']).to eq('RAMIREZ MARTINEZ JUAN JOSE') }
      end

      context 'concepto' do
        let(:concepto){ prueba.to_h['Conceptos'].first['Concepto'] }

        it{ expect(concepto['cantidad']).to eq(1) }
        it{ expect(concepto['unidad']).to eq('Servicio') }
        it{ expect(concepto['descripcion']).to eq('Pago de Nómina') }
        it{ expect(concepto['valorUnitario']).to eq(3100.00) }
        it{ expect(concepto['importe']).to eq(3100.00) }
      end

      context 'nomina' do
        let(:nomina){ prueba.to_h['Nomina'] }

        context 'complemento nomina' do
          let(:complemento){ nomina['ComplementoNomina'] }

          it { expect(complemento['RegistroPatronal']).to eq('P123456789') }
          it { expect(complemento['NumEmpleado']).to eq('2013001') }
          it { expect(complemento['CURP']).to eq('XEXX010101MOCNRR02') }
          it { expect(complemento['TipoRegimen']).to eq(1)}
          it { expect(complemento['NumSeguridadSocial']).to eq('12345678912')}
          it { expect(complemento['FechaPago']).to eq(hoy.strftime("%F"))}
          it { expect(complemento['FechaInicialPago']).to eq(inicio_quincena.strftime("%F"))}
          it { expect(complemento['FechaFinalPago']).to eq(fin_quincena.strftime("%F"))}
          it { expect(complemento['NumDiasPagados']).to eq(15)}
          it { expect(complemento['Departamento']).to eq('Desarrollo')}
          it { expect(complemento['CLABE']).to eq('123456789012345678')}
          it { expect(complemento['Banco']).to eq('012')}
          it { expect(complemento['FechaInicioRelLaboral']).to eq(inicio_relacion_laboral.strftime("%F"))}
          it { expect(complemento['Antiguedad']).to eq(48)}
          it { expect(complemento['Puesto']).to eq('Programador')}
          it { expect(complemento['TipoContrato']).to eq('Base')}
          it { expect(complemento['PeriodicidadPago']).to eq('Quincenal')}
          it { expect(complemento['SalarioBaseCotApor']).to eq(200.0)}
          it { expect(complemento['RiesgoPuesto']).to eq(5)}
          it { expect(complemento['SalarioDiarioIntegrado']).to eq(209.04)}
        end

        context 'percepciones' do
          context 'primera percepcion' do
            let(:percepcion) { nomina['Percepciones'].first['Percepcion'] }

            it { expect(percepcion['TipoPercepcion']).to eq('001')}
            it { expect(percepcion['Clave']).to eq('001')}
            it{ expect(percepcion['Concepto']).to eq('Sueldos')}
            it { expect(percepcion['ImporteGravado']).to eq(3000.00)}
            it { expect(percepcion['ImporteExento']).to eq(0.00)}
          end

          context 'segunda percepcion' do
            let(:percepcion) { nomina['Percepciones'].last['Percepcion'] }

            it { expect(percepcion['TipoPercepcion']).to eq('019')}
            it { expect(percepcion['Clave']).to eq('019')}
            it { expect(percepcion['Concepto']).to eq('Horas extra')}
            it { expect(percepcion['ImporteGravado']).to eq(0.00)}
            it { expect(percepcion['ImporteExento']).to eq(100.00)}
          end
        end

        context 'deducciones' do
          context 'primera deduccion' do
            let(:deduccion) { nomina['Deducciones'][0]['Deduccion'] }

            it { expect(deduccion['TipoDeduccion']).to eq('002')}
            it { expect(deduccion['Clave']).to eq('001')}
            it { expect(deduccion['Concepto']).to eq('ISR')}
            it { expect(deduccion['Importe']).to eq(0.00)}
          end

          context 'segunda deduccion' do
            let(:deduccion) { nomina['Deducciones'][1]['Deduccion'] }

            it { expect(deduccion['TipoDeduccion']).to eq('001')}
            it { expect(deduccion['Clave']).to eq('002')}
            it { expect(deduccion['Concepto']).to eq('IMSS')}
            it { expect(deduccion['Importe']).to eq(0.00)}
          end

          context 'tercera deduccion' do
            let(:deduccion) { nomina['Deducciones'][2]['Deduccion'] }

            it { expect(deduccion['TipoDeduccion']).to eq('006')}
            it { expect(deduccion['Clave']).to eq('006')}
            it { expect(deduccion['Concepto']).to eq('Descuento por incapacidad')}
            it { expect(deduccion['Importe']).to eq(0.00)}
          end
        end

        context 'incapacidades' do
          context 'primera incapacidad' do
            let(:incapacidad) { nomina['Incapacidades'].first['Incapacidad'] }

            it { expect(incapacidad['DiasIncapacidad']).to eq(1)}
            it { expect(incapacidad['TipoIncapacidad']).to eq(2)}
            it { expect(incapacidad['ImporteMonetario']).to eq(200.00)}
          end
        end

        context 'horas extra' do
          context 'primera hora extra' do
            let(:hora_extra) { nomina['InformacionHorasExtra'].first['HorasExtra'] }

            it { expect(hora_extra['Dias']).to eq(1)}
            it { expect(hora_extra['TipoHoras']).to eq('Dobles')}
            it { expect(hora_extra['HorasExtra']).to eq(1)}
            it { expect(hora_extra['ImportePagado']).to eq(100.00)}
          end
        end

      end

      context 'salida en texto' do
        let(:salida){ prueba.to_s }

        it { expect(salida).to match(/\[Encabezado\]/) }
        it { expect(salida).to match(/\[Datos Adicionales\]/) }
        it { expect(salida).to match(/\[Emisor\]/) }
        it { expect(salida).to match(/\[Receptor\]/) }
        it { expect(salida).to match(/\[Concepto\]/) }
        it { expect(salida).to match(/\[ComplementoNomina\]/) }
        it { expect(salida).to match(/\[Percepcion\]/) }
        it { expect(salida).to match(/\[Deduccion\]/) }
        it { expect(salida).to match(/\[Incapacidad\]/) }
        it { expect(salida).to match(/\[HorasExtra\]/) }
      end
    end
  end
end
