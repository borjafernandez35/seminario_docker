import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controllers/userModelController.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserModelController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil de Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final user = userController.user.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nombre: ${user.name}'),
              Text('Email: ${user.mail}'),
              Text('Comentario: ${user.comment}'),
              const SizedBox(height: 20),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.arrow_drop_down_circle),
                      title: const Text('Card title 1'),
                      subtitle: Text(
                        'Secondary Text',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    OverflowBar(
                      alignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF6200EE),
                          ),
                          onPressed: () {
                            // Acción para el botón ACTION 1
                          },
                          child: const Text('ACTION 1'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF6200EE),
                          ),
                          onPressed: () {
                            // Acción para el botón ACTION 2
                          },
                          child: const Text('ACTION 2'),
                        ),
                      ],
                    ),
                    /* Image.asset('assets/card-sample-image.jpg'),
                    Image.asset('assets/card-sample-image-2.jpg'), */
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
