import 'package:dio/dio.dart';
import 'consultor_response.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://127.0.0.1:8000'; // cambiar por localhost o la URL

  Future<ConsultorResponse> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/consultordata', // Ajustar segun la ruta del login en laravel(el route)
        data: {
          'usuario': username,
          'clave': password,
        },
      );
      if (response.statusCode == 200) {
        return ConsultorResponse.fromJson(response.data['data']); // 
      } else {
        throw Exception('Error en la solicitud de inicio de sesión');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Error del servidor con respuesta
        throw Exception('Error: ${e.response?.data['message']}');
      } else {
        // Error del servidor sin respuesta
        throw Exception('Error en la solicitud: ${e.message}');
      }
    }
  }
}
