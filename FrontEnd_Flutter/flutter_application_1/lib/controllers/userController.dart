import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/services/user.dart';
import 'package:flutter_application_1/controllers/userModelController.dart';

class UserController extends GetxController {
  final UserService userService = UserService();
  final UserModelController userModelController = Get.find();

  // Controladores de texto para la UI
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Variables reactivas para la UI
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  void logIn() async {
    // Validación de campos
    if (mailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Campos vacíos',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Validación de formato de correo electrónico
    if (!GetUtils.isEmail(mailController.text)) {
      Get.snackbar('Error', 'Correo electrónico no válido',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    print('estoy en el login de usercontroller');

    final logIn = (
      mail: mailController.text,
      password: passwordController.text,
    );

    // Iniciar el proceso de inicio de sesión
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Llamada al servicio para iniciar sesión
      final responseData = await userService.logIn(logIn);

      print('el response data es:$responseData');

      // Manejo de respuesta exitosa
      Get.snackbar('Éxito', 'Inicio de sesión exitoso');
      Get.toNamed('/home');
        } catch (e) {
      errorMessage.value = 'Error: No se pudo conectar con la API';
    } finally {
      isLoading.value = false;
    }
  }
}
