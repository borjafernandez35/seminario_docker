import 'package:get/get.dart';
import 'package:flutter_application_1/models/userModel.dart';
import 'package:get_storage/get_storage.dart';

class UserModelController extends GetxController {
  final user = UserModel(
    name: 'Usuario desconocido',
    mail: 'No especificado',
    password: '',
    comment: '',
  ).obs;

  final GetStorage _storage = GetStorage(); // Instancia de GetStorage
  String? userId; // ID del usuario logueado

  @override
  void onInit() {
    super.onInit();
    loadCurrentUser();
  }

  void loadCurrentUser() {
    userId = _storage.read<String>('userId'); // Cargar el userId almacenado
    if (userId != null) {
      print("Usuario logueado: $userId");
    } else {
      print("No se encontró el ID del usuario logueado");
    }
  }

  void saveCurrentUser(String id) {
    userId = id;
    _storage.write('userId', id); // Guardar el userId en almacenamiento local
    print("Usuario guardado con ID: $id");
  }

  void setUser(String name, String mail, String password, String comment) {
    user.update((val) {
      if (val != null) {
        val.setUser(name, mail, password, comment);
        _storage.write('user', val.toJson()); // Guarda el usuario completo
      }
    });
  }

  UserModel? getStoredUser() {
    final storedUser =
        _storage.read<Map<String, dynamic>>('user'); // Leer usuario
    if (storedUser != null) {
      return UserModel.fromJson(storedUser);
    }
    return null;
  }
}
