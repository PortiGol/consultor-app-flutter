import 'package:consultor_app/consultor_response.dart';
import 'package:consultor_app/pages/aprobacion_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.consultorData,
  });

  final ConsultorResponse consultorData;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menú',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('General'),
            onTap: () {
              // Lógica para mostrar los datos generales (la vista actual)
              Navigator.pop(context); // Cierra el drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('¿Cuánto hacer simio para pasar?'),
            onTap: () {
              // ir a la pantalla para saber cuanto hacer para pasar
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AprobacionScreen(consultorData: consultorData),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}