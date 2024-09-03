import 'package:consultor_app/consultor_response.dart';
import 'package:flutter/material.dart';

class AprobacionScreen extends StatelessWidget {
  final ConsultorResponse consultorData;

  AprobacionScreen({required this.consultorData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('¿Cuánto hacer para pasar?'),
      ),
      body: const Center(
        child: Text('Esta función aún está en desarrollo.'),
      ),
    );
  }
}
