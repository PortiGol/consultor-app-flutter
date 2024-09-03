import 'package:dio/dio.dart';
import 'consultor_response.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl =
      'http://10.10.0.223:8000'; // cambiar por localhost o la URL

  Future<ConsultorResponse> login(String username, String password) async {
    try {
      print("object");
      final response = await _dio.post(
        '$_baseUrl/consultordata', // Ajusta según la ruta del login en Laravel
        data: {
          'usuario': username,
          'clave': password,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      print(response);

      
      return ConsultorResponse.fromJson(response.data['data']); //
      
    } on DioException catch (e) {
      if (e.response != null) {
        // Error del servidor con respuesta
        print('Error: ${e.response?.data['message']}');
        throw Exception('Error: ${e.response?.data['message']}');
      } else {
        // Error del servidor sin respuesta
        print('Error: ${e.message}');
        throw Exception('Error en la solicitud: ${e.message}');
      }
    }
  }
}
