import 'package:flutter_application_1/models/experienceModel.dart';
import 'package:dio/dio.dart';



class ExperienceService {
  final String baseUrl = "http://127.0.0.1:3000"; // URL de tu backend web
  //final String baseUrl = "http://10.0.2.2:3000"; // URL de tu backend Android
  final Dio dio = Dio(); // Usa el prefijo 'Dio' para referenciar la clase Dio
  var statusCode;
  var data;


  //Función createUser
   Future<int> createExperience(ExperienceModel newExperience) async {
    try {
      final response = await dio.post(
        '$baseUrl/experiencias',
        data: newExperience.toJson(),
      );
      return response.statusCode ?? -1;
    } catch (e) {
      print('Error al crear experiencia: $e');
      rethrow;
    }
  }

  Future<List<ExperienceModel>> getExperiences() async {
  try {
    final response = await dio.get('$baseUrl/experiencias');
    if (response.statusCode == 200 && response.data != null) {
      // Validar si data es realmente una lista
      if (response.data is List) {
        return (response.data as List)
            .map((item) => ExperienceModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('El formato de la respuesta no es una lista');
      }
    } else {
      throw Exception('Respuesta no válida del servidor');
    }
  } catch (e) {
    print('Error al obtener experiencias: $e');
    rethrow;
  }
}

  Future<int> editExperience(ExperienceModel newExperience, String id) async {
    try {
      final response = await dio.put(
        '$baseUrl/experiencias/$id',
        data: newExperience.toJson(),
      );
      return response.statusCode ?? -1;
    } catch (e) {
      print('Error al editar experiencia: $e');
      rethrow;
    }
  }

  Future<int> deleteExperience(String id) async {
    try {
      final response = await dio.delete('$baseUrl/experiencias/$id');
      return response.statusCode ?? -1;
    } catch (e) {
      print('Error al eliminar experiencia: $e');
      rethrow;
    }
  }

  


}