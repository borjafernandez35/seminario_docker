import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/services/experience.dart';
import 'package:flutter_application_1/models/experienceModel.dart';
import 'package:flutter_application_1/models/userModel.dart';
import 'package:flutter_application_1/controllers/experienceListController.dart';
import 'package:flutter_application_1/services/user.dart';

class ExperienceController extends GetxController {
  final ExperienceService experienceService = ExperienceService();
  final UserService userService = UserService();
  final ExperienceListController experienceListController = Get.find();

  final TextEditingController descriptionController = TextEditingController();
  var selectedParticipants = <UserModel>[].obs; // Participantes seleccionados
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  /// Alternar selección de participantes
  void toggleParticipant(UserModel user) {
    if (selectedParticipants.contains(user)) {
      selectedParticipants.remove(user);
    } else {
      selectedParticipants.add(user);
    }
  }

  /// Validar entradas antes de crear experiencia
  bool validateInputs() {
    if (descriptionController.text.isEmpty) {
      errorMessage.value = 'La descripción no puede estar vacía';
      return false;
    }
    if (selectedParticipants.isEmpty) {
      errorMessage.value = 'Debe seleccionar al menos un participante';
      return false;
    }
    return true;
  }

  /// Crear nueva experiencia
  void createExperience() async {
    final ownerId = userService.getId();

    if (!validateInputs() || ownerId == null) {
      Get.snackbar('Error', errorMessage.value, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;

    try {
      // Extraer IDs de los participantes seleccionados
      final participantIds = selectedParticipants.map((u) => u.id).where((id) => id!.isNotEmpty).toList();

      // Crear modelo de experiencia
      ExperienceModel newExperience = ExperienceModel(
        id: '',
        owner: ownerId,
        participants: participantIds,
        description: descriptionController.text.trim(),
      );

      // Llamar al servicio para crear la experiencia
      final response = await experienceService.createExperience(newExperience);

      if (response == 201) {
        experienceListController.fetchExperiences(); // Actualizar lista de experiencias
        Get.snackbar('Éxito', 'Experiencia creada exitosamente', snackPosition: SnackPosition.BOTTOM);
        clearInputs(); // Limpiar campos después de crear
      } else {
        throw Exception('Error al crear experiencia');
      }
    } catch (e) {
      Get.snackbar('Error', 'No se pudo crear la experiencia: $e', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false; // Restaurar estado de carga
    }
  }

  /// Limpiar los campos y la selección después de crear
  void clearInputs() {
    descriptionController.clear();
    selectedParticipants.clear();
  }
}


