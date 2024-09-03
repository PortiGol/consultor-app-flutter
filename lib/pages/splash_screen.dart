import 'package:consultor_app/api_service.dart';
import 'package:consultor_app/consultor_response.dart';
import 'package:consultor_app/login_screen.dart';
import 'package:consultor_app/pages/data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: ifUserExistRedir(), builder: (BuildContext context, AsyncSnapshot<ConsultorResponse?> snapshot) {
        // Mientras se obtiene el resultado de Future
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data != null) {
          // Si hay un usuario y los datos de login son correctos, redirigimos al homepage
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => DataScreen(consultorData: (snapshot.data as ConsultorResponse))));
          });

          return SizedBox.shrink(); // Devolvemos un widget vacío mientras redirigimos
        } else {
          
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
          });
          
          
          return Center(child: Text('No se encontró un usuario guardado'));
        }
      },);
  }

  Future<ConsultorResponse?> ifUserExistRedir() async{
    FlutterSecureStorage storage = FlutterSecureStorage();
  String? usuario = await storage.read(key: "usuario");
  String? clave = await storage.read(key: "clave");
    if (usuario == null ) {
      return null;
    }else{
      final ApiService _apiService = ApiService();
      final ConsultorResponse consultorData = await _apiService.login(
        usuario!,
        clave!
      );
      return consultorData;
    }
  }
}