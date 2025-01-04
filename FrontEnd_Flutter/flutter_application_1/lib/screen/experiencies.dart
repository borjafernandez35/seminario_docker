import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controllers/experienceListController.dart';
import 'package:flutter_application_1/widgets/experienceCard.dart';
import 'package:flutter_application_1/widgets/experienceDialog.dart';

class ExperiencePage extends StatelessWidget {
  ExperiencePage({super.key});

   final ExperienceListController experienceListController =
      Get.put(ExperienceListController());

  @override
  Widget build(BuildContext context) {
 

    return Scaffold(
      appBar: AppBar(title: const Text('Experiencias')),
      body: Obx(() {
        if (experienceListController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (experienceListController.experienceList.isEmpty) {
          return const Center(
            child: Text(
              "No hay experiencias disponibles",
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return ListView.builder(
          itemCount: experienceListController.experienceList.length,
          itemBuilder: (context, index) {
            final experience = experienceListController.experienceList[index];
            return ExperienceCard(experience: experience, key: ValueKey(experience.id));
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const CreateExperienceDialog()),
        child: const Icon(Icons.add),
      ),
    );
  }
}


