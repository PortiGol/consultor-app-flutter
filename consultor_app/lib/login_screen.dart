import 'package:flutter/material.dart';
import 'api_service.dart';
import 'data_screen.dart';
import 'consultor_response.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      // Await para esperar la respuesta del consultor
      final ConsultorResponse consultorData = await _apiService.login(
        _usernameController.text,
        _passwordController.text,
      );
      
      // ir a DataScreen con el objeto ConsultorResponse
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DataScreen(consultorData: consultorData),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')), 
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Usuario',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Clave',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
