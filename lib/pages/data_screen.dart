import 'package:consultor_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../consultor_response.dart';

class DataScreen extends StatelessWidget {
  final ConsultorResponse consultorData;

  DataScreen({required this.consultorData});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
            FlutterNativeSplash.remove();
          });
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultor Data'),
      ),
      drawer: MainDrawer(consultorData: consultorData),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${consultorData.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildSectionTitle('Inscripciones'),
            _buildInscripcionesTable(consultorData.inscripciones, context),
            SizedBox(height: 16),
            _buildSectionTitle('Pagos Efectuados'),
            _buildPagosTable(consultorData.pagosEfectuados),
            SizedBox(height: 16),
            _buildSectionTitle('Resultados Parciales'),
            _buildResultadosParcialesTable(consultorData.resultadosParciales),
            SizedBox(height: 16),
            _buildSectionTitle('Habilitaciones'),
            _buildHabilitacionesTable(consultorData.habilitaciones),
            SizedBox(height: 16),
            _buildSectionTitle('Evaluaciones Finales'),
            _buildEvaluacionesFinalesTable(consultorData.evaluacionesFinales),
            SizedBox(height: 16),
            _buildSectionTitle('Calificaciones'),
            _buildCalificacionesTable(consultorData.calificaciones),
            SizedBox(height: 16),
            _buildSectionTitle('Extensiones'),
            _buildExtensionesTable(consultorData.extensiones),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
    );
  }
//tablas...
  Widget _buildInscripcionesTable(List<Inscripcion> inscripciones, BuildContext context) {
    var witdh = MediaQuery.of(context).size.width;
    return _buildStyledDataTable(
      columns: [
        DataColumn(label: Text('Materia', style: TextStyle(fontStyle: FontStyle.italic))),
        DataColumn(label: Text('Fecha Inscripción')),
        DataColumn(label: Text('Validez')),
        DataColumn(label: Text('Grupo')),
        DataColumn(label: Text('Porcentaje Asistencia')),
      ],
      rows: inscripciones.map((inscripcion) {
        return DataRow(cells: [
          DataCell(Text(inscripcion.materia, style: TextStyle(fontSize: witdh/40 ),)),
          DataCell(Text(inscripcion.fechaInscripcion)),
          DataCell(Text(inscripcion.validez)),
          DataCell(Text(inscripcion.grupo)),
          DataCell(Text(inscripcion.porcentajeAsistencia)),
        ]);
      }).toList(),
    );
  }

  Widget _buildPagosTable(List<Pago> pagos) {
    return _buildStyledDataTable(
      columns: [
        DataColumn(label: Text('Arancel')),
        DataColumn(label: Text('Vencimiento')),
        DataColumn(label: Text('Fecha Pago')),
        DataColumn(label: Text('Importe')),
        DataColumn(label: Text('Situación')),
      ],
      rows: pagos.map((pago) {
        return DataRow(cells: [
          DataCell(Text(pago.arancel)),
          DataCell(Text(pago.vencimiento)),
          DataCell(Text(pago.fechaPago)),
          DataCell(Text(pago.importe)),
          DataCell(Text(pago.situacion)),
        ]);
      }).toList(),
    );
  }

  Widget _buildResultadosParcialesTable(List<ResultadoParcial> resultados) {
    return _buildStyledDataTable(
      columns: [
        DataColumn(label: Text('Materia')),
        DataColumn(label: Text('1ra Parcial')),
        DataColumn(label: Text('2da Parcial')),
        DataColumn(label: Text('Trab. Práctico')),
        DataColumn(label: Text('Trab. Laboratorio')),
        DataColumn(label: Text('Evaluación')),
      ],
      rows: resultados.map((resultado) {
        return DataRow(cells: [
          DataCell(Text(resultado.materia)),
          DataCell(Text(resultado.primeraParcial)),
          DataCell(Text(resultado.segundaParcial)),
          DataCell(Text(resultado.trabajoPractico)),
          DataCell(Text(resultado.trabajoLaboratorio)),
          DataCell(Text(resultado.evaluacion)),
        ]);
      }).toList(),
    );
  }

  Widget _buildHabilitacionesTable(List<Habilitacion> habilitaciones) {
    return _buildStyledDataTable(
      columns: [
        DataColumn(label: Text('Materia')),
        DataColumn(label: Text('Bonificación')),
        DataColumn(label: Text('Vencimiento')),
        DataColumn(label: Text('Periodo')),
      ],
      rows: habilitaciones.map((habilitacion) {
        return DataRow(cells: [
          DataCell(Text(habilitacion.materia)),
          DataCell(Text(habilitacion.bonificacion)),
          DataCell(Text(habilitacion.vencimiento)),
          DataCell(Text(habilitacion.periodo)),
        ]);
      }).toList(),
    );
  }

  Widget _buildEvaluacionesFinalesTable(List<EvaluacionFinal> evaluaciones) {
    return _buildStyledDataTable(
      columns: [
        DataColumn(label: Text('Materia')),
        DataColumn(label: Text('Fecha')),
        DataColumn(label: Text('Final (100%)')),
        DataColumn(label: Text('Bonificación')),
        DataColumn(label: Text('Total')),
        DataColumn(label: Text('Nota')),
      ],
      rows: evaluaciones.map((evaluacion) {
        return DataRow(cells: [
          DataCell(Text(evaluacion.materia)),
          DataCell(Text(evaluacion.fecha)),
          DataCell(Text(evaluacion.final100)),
          DataCell(Text(evaluacion.bonificacion)),
          DataCell(Text(evaluacion.total)),
          DataCell(Text(evaluacion.nota)),
        ]);
      }).toList(),
    );
  }

  Widget _buildCalificacionesTable(List<Calificacion> calificaciones) {
    if (calificaciones.isEmpty) {
      return Text('No hay calificaciones disponibles.');
    }

    return _buildStyledDataTable(
      columns: [
        DataColumn(label: Text('Materia')),
        DataColumn(label: Text('Semestre')),
        DataColumn(label: Text('Fecha')),
        DataColumn(label: Text('Nota')),
        DataColumn(label: Text('Acta')),
      ],
      rows: calificaciones.map((calificacion) {
        return DataRow(cells: [
          DataCell(Text(calificacion.materia)),
          DataCell(Text(calificacion.semestre)),
          DataCell(Text(calificacion.fecha)),
          DataCell(Text(calificacion.nota)),
          DataCell(Text(calificacion.acta)),
        ]);
      }).toList(),
    );
  }

  Widget _buildExtensionesTable(List<Extension> extensiones) {
    return _buildStyledDataTable(
      columns: [
        DataColumn(label: Text('Actividad')),
        DataColumn(label: Text('Carrera')),
        DataColumn(label: Text('Tipo de Actividad')),
        DataColumn(label: Text('Máxima Cantidad')),
        DataColumn(label: Text('Cantidad')),
        DataColumn(label: Text('Horas')),
      ],
      rows: extensiones.map((extension) {
        return DataRow(cells: [
          DataCell(Text(extension.actividad)),
          DataCell(Text(extension.carrera)),
          DataCell(Text(extension.tipoActividad)),
          DataCell(Text(extension.maximaCantidad)),
          DataCell(Text(extension.cantidad)),
          DataCell(Text(extension.horas)),
        ]);
      }).toList(),
    );
  }

  Widget _buildStyledDataTable({required List<DataColumn> columns, required List<DataRow> rows}) {
    return DataTable(
      headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue.shade100),
      dataRowColor: MaterialStateColor.resolveWith((states) => Colors.blue.shade50),
      columns: columns,
      rows: rows,
    );
  }
}



