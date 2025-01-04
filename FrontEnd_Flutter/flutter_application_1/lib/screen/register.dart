import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controllers/registerController.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inicializar el controlador dentro de build
    final RegisterController registerController = Get.put(RegisterController());

    return Scaffold(
      appBar: AppBar(title: const Text('Registrarse')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: registerController.nameController,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: registerController.mailController,
              decoration: const InputDecoration(labelText: 'Correo Electrónico'),
            ),
            TextField(
              controller: registerController.passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            TextField(
              controller: registerController.commentController,
              decoration: const InputDecoration(labelText: 'Comentario'),
            ),
            const SizedBox(height: 16),
            
            // Mostrar CircularProgressIndicator o botón de registro según el estado de carga
            Obx(() {
              if (registerController.isLoading.value) {
                return const CircularProgressIndicator();
              } else {
                return ElevatedButton(
                  onPressed: registerController.signUp,
                  child: const Text('Registrarse'),
                );
              }
            }),

            // Mostrar mensaje de error si existe
            Obx(() {
              if (registerController.errorMessage.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    registerController.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return Container();
              }
            }),

            const SizedBox(height: 16),
            
            // Botón para volver a la página de inicio de sesión
            ElevatedButton(
              onPressed: () => Get.toNamed('/login'),
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}

