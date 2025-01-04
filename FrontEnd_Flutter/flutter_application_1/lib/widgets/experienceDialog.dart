import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controllers/experienceController.dart';
import 'package:flutter_application_1/controllers/userListController.dart';

class CreateExperienceDialog extends StatelessWidget {
  const CreateExperienceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final ExperienceController experienceController = Get.put(ExperienceController());
    final UserListController userListController = Get.put(UserListController());

    return Scaffold(
      appBar: AppBar(title: const Text('Crear Experiencia')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nueva Experiencia',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: experienceController.descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Obx(() {
                final userList = userListController.userList;

                if (userList.isEmpty) {
                  return const Center(
                    child: Text('No hay usuarios disponibles'),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Seleccionar participantes',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          final user = userList[index];
                          final isSelected = experienceController.selectedParticipants
                              .any((selectedUser) => selectedUser.id == user.id);

                          return ListTile(
                            key: ValueKey(user.id),
                            title: Text(user.name),
                            subtitle: Text(user.mail),
                            trailing: IconButton(
                              icon: Icon(
                                isSelected ? Icons.check_box_outline_blank : Icons.check_box,
                              ),
                              onPressed: () => experienceController.toggleParticipant(user),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (experienceController.validateInputs()) {
                        experienceController.createExperience();
                        Get.back();
                      } else {
                        Get.snackbar(
                          'Error',
                          'Por favor completa todos los campos',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
