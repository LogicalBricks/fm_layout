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
        FmLayout.define_layout_nomina do |f|
          f.recibo_nomina do |e|
            e.serie 'RN'
            e.folio '105'
            e.fecha '2016-11-29T16:07:43'
            e.subtotal '4420.00'
            e.descuento '193.43'
            e.total '4226.57'
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
            e.regimen '612'
          end

          f.entidad_sncf do |e|
            e.origen_recurso 'IM'
            e.monto_recurso_propio 750
          end

          f.receptor do |r|
            r.rfc 'XAXX010101000'
            r.nombre 'RAMIREZ MARTINEZ JUAN JOSE'
            r.curp 'XEXX010101MOCNRR02'
            r.numero_seguridad_social '12345678912'
            r.fecha_inicio_relacion_laboral inicio_relacion_laboral.strftime("%F")
            r.antiguedad "P52W"
            r.tipo_contrato '01'
            r.tipo_jornada '04'
            r.tipo_regimen '02'
            r.numero_empleado '2013001'
            r.departamento 'Desarrollo'
            r.puesto 'Programador'
            r.riesgo_puesto 5
            r.periodicidad_pago '04'
            r.banco '002'
            r.salario_base 200
            r.salario_diario_integrado 209.04
            r.clave_entidad_federativa 'OAX'
          end

          f.concepto do |c|
            c.valor_unitario 3100.00
            c.importe 3100.00
          end

          f.nomina do |n|
            n.complemento_nomina do |c|
              c.tipo_nomina 'O'
              c.fecha_de_pago hoy.strftime("%F")
              c.fecha_inicial_de_pago inicio_quincena.strftime("%F")
              c.fecha_final_de_pago fin_quincena.strftime("%F")
              c.dias_pagados 15
            end

            n.percepcion do |p|
              p.tipo '039'
              p.clave '039'
              p.concepto 'Jubilaciones, pensiones o haberes de retiro'
              p.importe_gravado 3000
              p.importe_exento 0
            end

            n.percepcion do |p|
              p.tipo '019'
              p.clave '019'
              p.concepto 'Horas extra'
              p.importe_gravado 0.0
              p.importe_exento 100.0
              p.horas_extra do |h|
                h.dias 1
                h.tipo 'Dobles'
                h.horas_extra 1
                h.importe 100.0
              end
            end

            n.percepcion do |p|
              p.tipo '045'
              p.clave '045'
              p.concepto 'Acción o Título'
              p.importe_gravado 3000
              p.importe_exento 0
              p.valor_mercado 200
              p.precio_al_otorgarse 20
            end

            n.percepcion do |p|
              p.tipo '022'
              p.clave '022'
              p.concepto 'Separacion Indemnizacion'
              p.importe_gravado 3000
              p.importe_exento 0
            end

            n.jubilacion_pension_retiro do |j|
              j.total_una_exhibicion 500
              j.ingreso_acumulable 200
              j.ingreso_no_acumulable 20
            end

            n.separacion_indemnizacion do |s|
              s.total_pagado 10000
              s.numero_anios_servicio 2
              s.ultimo_sueldo_mensual 20000
              s.ingreso_acumulable 20000
              s.ingreso_no_acumulable 500
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

            n.otro_pago do |op|
              op.tipo '002'
              op.clave '002'
              op.concepto 'Un concepto'
              op.importe 250.5
              op.subsidio_causado 20.3
            end

            n.otro_pago do |op|
              op.tipo '004'
              op.clave '004'
              op.concepto 'Un concepto'
              op.importe 350.5
              op.saldo 200.0
              op.anio 2016
              op.remanente_saldo 100.0
            end

            n.otro_pago do |op|
              op.tipo '001'
              op.clave '001'
              op.concepto 'Un concepto'
              op.importe 150.5
            end

            n.incapacidad do |i|
              i.dias 1
              i.tipo 2
              i.importe_monetario 200.00
            end

          end
        end
      end

      context 'recibo_nomina' do
        let(:recibo_nomina){ prueba.to_h['ReciboNomina'] }
        it{ expect(recibo_nomina['serie']).to eq('RN') }
        it{ expect(recibo_nomina['folio']).to eq('105') }
        it{ expect(recibo_nomina['fecha']).to eq('2016-11-29T16:07:43') }
        it{ expect(recibo_nomina['subTotal']).to eq('4420.00') }
        it{ expect(recibo_nomina['descuento']).to eq('193.43') }
        it{ expect(recibo_nomina['total']).to eq('4226.57') }
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
        it{ expect(emisor['Regimen']).to eq('612') }
      end

      context 'entidad_sncf' do
        let(:entidad){ prueba.to_h['EntidadSNCF'] }

        it{ expect(entidad['OrigenRecurso']).to eq('IM') }
        it{ expect(entidad['MontoRecursoPropio']).to eq(750) }
      end

      context 'receptor' do
        let(:receptor){ prueba.to_h['Receptor'] }

        it{ expect(receptor['rfc']).to eq('XAXX010101000') }
        it{ expect(receptor['nombre']).to eq('RAMIREZ MARTINEZ JUAN JOSE') }
        it{ expect(receptor['Curp']).to eq('XEXX010101MOCNRR02') }
        it { expect(receptor['NumSeguridadSocial']).to eq('12345678912')}
        it { expect(receptor['FechaInicioRelLaboral']).to eq(inicio_relacion_laboral.strftime("%F"))}
        it { expect(receptor['Antigüedad']).to eq("P52W")}
        it { expect(receptor['TipoContrato']).to eq('01')}
        it { expect(receptor['TipoJornada']).to eq('04')}
        it { expect(receptor['TipoRegimen']).to eq('02')}
        it { expect(receptor['NumEmpleado']).to eq('2013001') }
        it { expect(receptor['Departamento']).to eq('Desarrollo')}
        it { expect(receptor['Puesto']).to eq('Programador')}
        it { expect(receptor['RiesgoPuesto']).to eq(5)}
        it { expect(receptor['PeriodicidadPago']).to eq('04')}
        it { expect(receptor['Banco']).to eq('002')}
        it { expect(receptor['SalarioBaseCotApor']).to eq(200.0)}
        it { expect(receptor['SalarioDiarioIntegrado']).to eq(209.04)}
        it { expect(receptor['ClaveEntFed']).to eq('OAX')}
      end

      context 'concepto' do
        let(:concepto){ prueba.to_h['Conceptos'].first['Concepto#1'] }

        it{ expect(concepto['cantidad']).to eq(1) }
        it{ expect(concepto['unidad']).to eq('ACT') }
        it{ expect(concepto['descripcion']).to eq('Pago de nómina') }
        it{ expect(concepto['valorUnitario']).to eq(3100.00) }
        it{ expect(concepto['importe']).to eq(3100.00) }
      end

      context 'nomina' do
        let(:nomina){ prueba.to_h['Nomina'] }

        context 'complemento nomina' do
          let(:complemento){ nomina['ComplementoNomina'] }

          it { expect(complemento['Version']).to eq('1.2') }
          it { expect(complemento['TipoNomina']).to eq('O') }
          it { expect(complemento['FechaPago']).to eq(hoy.strftime("%F"))}
          it { expect(complemento['FechaInicialPago']).to eq(inicio_quincena.strftime("%F"))}
          it { expect(complemento['FechaFinalPago']).to eq(fin_quincena.strftime("%F"))}
          it { expect(complemento['NumDiasPagados']).to eq(15)}
        end

        context 'percepciones' do
          context 'primera percepcion' do
            let(:percepcion) { nomina['Percepciones'].first['Percepcion#1'] }

            it { expect(percepcion['TipoPercepcion']).to eq('039')}
            it { expect(percepcion['Clave']).to eq('039')}
            it{ expect(percepcion['Concepto']).to eq('Jubilaciones, pensiones o haberes de retiro')}
            it { expect(percepcion['ImporteGravado']).to eq(3000.00)}
            it { expect(percepcion['ImporteExento']).to eq(0.00)}
          end

          context 'segunda percepcion' do
            let(:percepcion) { nomina['Percepciones'][1]['Percepcion#2'] }

            it { expect(percepcion['TipoPercepcion']).to eq('019')}
            it { expect(percepcion['Clave']).to eq('019')}
            it { expect(percepcion['Concepto']).to eq('Horas extra')}
            it { expect(percepcion['ImporteGravado']).to eq(0.00)}
            it { expect(percepcion['ImporteExento']).to eq(100.00)}
            it { expect(percepcion["HorasExtra.Dias"]).to eq('[1]')}
            it { expect(percepcion["HorasExtra.TipoHoras"]).to eq('[Dobles]')}
            it { expect(percepcion["HorasExtra.HorasExtra"]).to eq('[1]')}
            it { expect(percepcion["HorasExtra.ImportePagado"]).to eq('[100.0]')}
          end

          context 'tercera percepcion' do
            let(:percepcion) { nomina['Percepciones'][2]['Percepcion#3'] }

            it { expect(percepcion['TipoPercepcion']).to eq('045')}
            it { expect(percepcion['Clave']).to eq('045')}
            it { expect(percepcion['Concepto']).to eq('Acción o Título')}
            it { expect(percepcion['ImporteGravado']).to eq(3000.00)}
            it { expect(percepcion['ImporteExento']).to eq(0.00)}
            it { expect(percepcion['AccionesOTitulos.ValorMercado']).to eq 200  }
            it { expect(percepcion['AccionesOTitulos.PrecioAlOtorgarse']).to eq 20  }
          end

          context 'cuarta percepcion' do
            let(:percepcion) { nomina['Percepciones'][3]['Percepcion#4'] }

            it { expect(percepcion['TipoPercepcion']).to eq('022')}
            it { expect(percepcion['Clave']).to eq('022')}
            it { expect(percepcion['Concepto']).to eq('Separacion Indemnizacion')}
            it { expect(percepcion['ImporteGravado']).to eq(3000.00)}
            it { expect(percepcion['ImporteExento']).to eq(0.00)}
          end
        end

        context "Separación indemnizacion" do
          let(:separacion) { nomina['SeparacionIndemnizacion'] }

          it { expect(separacion['TotalPagado']).to eq(10000) }
          it { expect(separacion['NumAñosServicio']).to eq(2) }
          it { expect(separacion['UltimoSueldoMensOrd']).to eq(20000) }
          it { expect(separacion['IngresoAcumulable']).to eq(20000) }
          it { expect(separacion['IngresoNoAcumulable']).to eq(500) }
        end # context Separación indemnizacion

        context 'jubilación pensión retiro' do

          let(:jubilacion) { nomina['JubilacionPensionRetiro']}

          it { expect(jubilacion['TotalUnaExhibicion']).to eq 500  }
          it { expect(jubilacion['IngresoAcumulable']).to eq 200  }
          it { expect(jubilacion['IngresoNoAcumulable']).to eq 20  }
        end

        context 'deducciones' do
          context 'primera deduccion' do
            let(:deduccion) { nomina['Deducciones'][0]['Deduccion#1'] }

            it { expect(deduccion['TipoDeduccion']).to eq('002')}
            it { expect(deduccion['Clave']).to eq('001')}
            it { expect(deduccion['Concepto']).to eq('ISR')}
            it { expect(deduccion['Importe']).to eq(0.00)}
          end

          context 'segunda deduccion' do
            let(:deduccion) { nomina['Deducciones'][1]['Deduccion#2'] }

            it { expect(deduccion['TipoDeduccion']).to eq('001')}
            it { expect(deduccion['Clave']).to eq('002')}
            it { expect(deduccion['Concepto']).to eq('IMSS')}
            it { expect(deduccion['Importe']).to eq(0.00)}
          end

          context 'tercera deduccion' do
            let(:deduccion) { nomina['Deducciones'][2]['Deduccion#3'] }

            it { expect(deduccion['TipoDeduccion']).to eq('006')}
            it { expect(deduccion['Clave']).to eq('006')}
            it { expect(deduccion['Concepto']).to eq('Descuento por incapacidad')}
            it { expect(deduccion['Importe']).to eq(0.00)}
          end
        end

        context "otro pago" do
          context "primer otro pago" do
           let(:otro_pago) { nomina['OtroPagos'][0]['OtroPago#1'] }

           it { expect(otro_pago['TipoOtroPago']).to eq '002' }
           it { expect(otro_pago['Clave']).to eq '002' }
           it { expect(otro_pago['Concepto']).to eq 'Un concepto' }
           it { expect(otro_pago['Importe']).to eq 250.5 }
           it { expect(otro_pago['SubsidioAlEmpleo.SubsidioCausado']).to eq 20.3 }
          end # context primer otro pago

          context "segundo otro pago" do
           let(:otro_pago) { nomina['OtroPagos'][1]['OtroPago#2'] }

           it { expect(otro_pago['TipoOtroPago']).to eq '004' }
           it { expect(otro_pago['Clave']).to eq '004' }
           it { expect(otro_pago['Concepto']).to eq 'Un concepto' }
           it { expect(otro_pago['Importe']).to eq 350.5 }
           it { expect(otro_pago['CompensacionSaldosAFavor.SaldoAFavor']).to eq 200.0 }
           it { expect(otro_pago['CompensacionSaldosAFavor.Año']).to eq 2016 }
           it { expect(otro_pago['CompensacionSaldosAFavor.RemanenteSalFav']).to eq 100.0 }
          end # context segundo otro pago

          context "tercer otro pago" do
           let(:otro_pago) { nomina['OtroPagos'][2]['OtroPago#3'] }

           it { expect(otro_pago['TipoOtroPago']).to eq '001' }
           it { expect(otro_pago['Clave']).to eq '001' }
           it { expect(otro_pago['Concepto']).to eq 'Un concepto' }
           it { expect(otro_pago['Importe']).to eq 150.5 }
          end # context tercer otro pago

        end # context otro pago

        context 'incapacidades' do
          context 'primera incapacidad' do
            let(:incapacidad) { nomina['Incapacidades'].first['Incapacidad#1'] }

            it { expect(incapacidad['DiasIncapacidad']).to eq(1)}
            it { expect(incapacidad['TipoIncapacidad']).to eq(2)}
            it { expect(incapacidad['ImporteMonetario']).to eq(200.00)}
          end
        end

      end

      context 'salida en texto' do
        let(:salida){ prueba.to_s }
        it{ expect(salida).to match(/\[ReciboNomina\]/) }
        it{ expect(salida).to match(/\[Datos Adicionales\]/) }
        it{ expect(salida).to match(/\[Emisor\]/) }
        it{ expect(salida).to match(/\[EntidadSNCF\]/) }
        it{ expect(salida).to match(/\[Receptor\]/) }
        it{ expect(salida).to match(/\[Concepto#1\]/) }
        it{ expect(salida).to match(/\[ComplementoNomina\]/) }
        it{ expect(salida).to match(/\[Percepcion#1\]/) }
        it{ expect(salida).to match(/\[JubilacionPensionRetiro\]/) }
        it{ expect(salida).to match(/\[SeparacionIndemnizacion\]/) }
        it{ expect(salida).to match(/\[Deduccion#1\]/) }
        it{ expect(salida).to match(/\[Incapacidad#1\]/) }
      end
    end
  end
end
