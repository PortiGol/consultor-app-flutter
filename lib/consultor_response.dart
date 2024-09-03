import 'dart:core';
//parseo del Json (fromJson() y toJson()).....
class ConsultorResponse {
  final String name;
  final List<Inscripcion> inscripciones;
  final List<Pago> pagosEfectuados;
  final List<ResultadoParcial> resultadosParciales;
  final List<Habilitacion> habilitaciones;
  final List<EvaluacionFinal> evaluacionesFinales;
  final List<Calificacion> calificaciones;
  final List<Extension> extensiones;

  ConsultorResponse({
    required this.name,
    required this.inscripciones,
    required this.pagosEfectuados,
    required this.resultadosParciales,
    required this.habilitaciones,
    required this.evaluacionesFinales,
    required this.calificaciones,
    required this.extensiones,
  });

  factory ConsultorResponse.fromJson(Map<String, dynamic> json) {
    return ConsultorResponse(
      name: json['name'],
      inscripciones: (json['inscripciones'] as List)
          .map((i) => Inscripcion.fromJson(i))
          .toList(),
      pagosEfectuados: (json['pagos efectuados'] as List)
          .map((i) => Pago.fromJson(i))
          .toList(),
      resultadosParciales: (json['resultados parciales'] as List)
          .map((i) => ResultadoParcial.fromJson(i))
          .toList(),
      habilitaciones: (json['habilitaciones'] as List)
          .map((i) => Habilitacion.fromJson(i))
          .toList(),
      evaluacionesFinales: (json['evaluaciones finales'] as List)
          .map((i) => EvaluacionFinal.fromJson(i))
          .toList(),
      calificaciones: (json['calificaciones'] as List)
          .skipWhile((item) => item.isEmpty) // Ignorar  el primer elemento vacío(asi mante funciono xdxdxdxd)
          .map((i) => Calificacion.fromJson(i))
          .toList(),
      extensiones: (json['extensiones'] as List)
          .map((i) => Extension.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'inscripciones': inscripciones.map((i) => i.toJson()).toList(),
      'pagos efectuados': pagosEfectuados.map((i) => i.toJson()).toList(),
      'resultados parciales': resultadosParciales.map((i) => i.toJson()).toList(),
      'habilitaciones': habilitaciones.map((i) => i.toJson()).toList(),
      'evaluaciones finales': evaluacionesFinales.map((i) => i.toJson()).toList(),
      'calificaciones': calificaciones.map((i) => i.toJson()).toList(),
      'extensiones': extensiones.map((i) => i.toJson()).toList(),
    };
  }
}


class Inscripcion {
  final String materia;
  final String fechaInscripcion;
  final String validez;
  final String grupo;
  final String porcentajeAsistencia;

  Inscripcion({
    required this.materia,
    required this.fechaInscripcion,
    required this.validez,
    required this.grupo,
    required this.porcentajeAsistencia,
  });

  factory Inscripcion.fromJson(Map<String, dynamic> json) => Inscripcion(
        materia: json['materia'] ?? '',
        fechaInscripcion: json['fecha_inscripcion'] ?? '',
        validez: json['validez'] ?? '',
        grupo: json['grupo'] ?? '',
        porcentajeAsistencia: json['porcentaje_asistencia'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'materia': materia,
        'fecha_inscripcion': fechaInscripcion,
        'validez': validez,
        'grupo': grupo,
        'porcentaje_asistencia': porcentajeAsistencia,
      };
}
class Pago {
  final String arancel;
  final String vencimiento;
  final String fechaPago;
  final String importe;
  final String situacion;

  Pago({
    required this.arancel,
    required this.vencimiento,
    required this.fechaPago,
    required this.importe,
    required this.situacion,
  });

  factory Pago.fromJson(Map<String, dynamic> json) => Pago(
    arancel: json['Arancel'] ?? '',
    vencimiento: json['Vencimiento'] ?? '',
    fechaPago: json['Fecha_Pago'] ?? '',
    importe: json['Importe'] ?? '',
    situacion: json['Situacion'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'Arancel': arancel,
    'Vencimiento': vencimiento,
    'Fecha_Pago': fechaPago,
    'Importe': importe,
    'Situacion': situacion,
  };
}
class EvaluacionFinal {
  final String materia;
  final String fecha;
  final String final100;
  final String bonificacion;
  final String total;
  final String nota;

  EvaluacionFinal({
    required this.materia,
    required this.fecha,
    required this.final100,
    required this.bonificacion,
    required this.total,
    required this.nota,
  });

  factory EvaluacionFinal.fromJson(Map<String, dynamic> json) => EvaluacionFinal(
    materia: json['Materia'] ?? '',
    fecha: json['Fecha'] ?? '',
    final100: json['Final (100%)'] ?? '',
    bonificacion: json['Bonificacion'] ?? '',
    total: json['Total'] ?? '',
    nota: json['Nota'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'Materia': materia,
    'Fecha': fecha,
    'Final (100%)': final100,
    'Bonificacion': bonificacion,
    'Total': total,
    'Nota': nota,
  };
}
class ResultadoParcial {
  final String materia;
  final String primeraParcial;
  final String segundaParcial;
  final String trabajoPractico;
  final String trabajoLaboratorio;
  final String evaluacion;

  ResultadoParcial({
    required this.materia,
    required this.primeraParcial,
    required this.segundaParcial,
    required this.trabajoPractico,
    required this.trabajoLaboratorio,
    required this.evaluacion,
  });

  factory ResultadoParcial.fromJson(Map<String, dynamic> json) {
    return ResultadoParcial(
      materia: json['Materia'] ?? '',
      primeraParcial: json['1ra parcial'] ?? '',
      segundaParcial: json['2da parcial'] ?? '',
      trabajoPractico: json['Trab.Practico'] ?? '',
      trabajoLaboratorio: json['Trab.Laboratorio'] ?? '',
      evaluacion: json['Evaluacion'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Materia': materia,
      '1ra parcial': primeraParcial,
      '2da parcial': segundaParcial,
      'Trab.Practico': trabajoPractico,
      'Trab.Laboratorio': trabajoLaboratorio,
      'Evaluacion': evaluacion,
    };
  }
}

class Habilitacion {
  final String materia;
  final String bonificacion;
  final String vencimiento;
  final String periodo;

  Habilitacion({
    required this.materia,
    required this.bonificacion,
    required this.vencimiento,
    required this.periodo,
  });

  factory Habilitacion.fromJson(Map<String, dynamic> json) => Habilitacion(
    materia: json['Materia'] ?? '',
    bonificacion: json['Bonificacion'] ?? '',
    vencimiento: json['Vencimiento'] ?? '',
    periodo: json['Periodo'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'Materia': materia,
    'Bonificacion': bonificacion,
    'Vencimiento': vencimiento,
    'Periodo': periodo,
  };
}
class Calificacion {
  final String materia;
  final String semestre;
  final String fecha;
  final String nota;
  final String acta;

  Calificacion({
    required this.materia,
    required this.semestre,
    required this.fecha,
    required this.nota,
    required this.acta,
  });

  factory Calificacion.fromJson(Map<String, dynamic> json) => Calificacion(
    materia: json['Materia'] ?? '',
    semestre: json['Semestre'] ?? '',
    fecha: json['Fecha'] ?? '',
    nota: json['Nota'] ?? '',
    acta: json['Acta'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'Materia': materia,
    'Semestre': semestre,
    'Fecha': fecha,
    'Nota': nota,
    'Acta': acta,
  };
}
class Extension {
  final String carrera;
  final String actividad;
  final String tipoActividad;
  final String maximaCantidad;
  final String cantidad;
  final String horas;

  Extension({
    required this.carrera,
    required this.actividad,
    required this.tipoActividad,
    required this.maximaCantidad,
    required this.cantidad,
    required this.horas,
  });

  factory Extension.fromJson(Map<String, dynamic> json) => Extension(
    carrera: json['Carrera'] ?? '',
    actividad: json['Actividad'] ?? '',
    tipoActividad: json['Tipo Actividad'] ?? '',
    maximaCantidad: json['Maxima '] ?? '',
    cantidad: json['Cantidad'] ?? '',
    horas: json['Horas'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'Carrera': carrera,
    'Actividad': actividad,
    'Tipo de actividad': tipoActividad,
    'Maxima': maximaCantidad,
    'Cantidad': cantidad,
    'Horas': horas,
  };
}
