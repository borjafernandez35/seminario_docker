import 'package:get/get.dart';
import 'package:flutter_application_1/services/experience.dart';
import 'package:flutter_application_1/models/experienceModel.dart';
import 'package:flutter_application_1/models/userModel.dart';

class ExperienceListController extends GetxController {
  var isLoading = true.obs; // Controla el estado de carga
  var experienceList = <ExperienceModel>[].obs; // Lista de experiencias
  var userList = <UserModel>[].obs;
  final ExperienceService experienceService =
      ExperienceService(); // Servicio para experiencias

  @override
  void onInit() {
    fetchExperiences(); // Cargar experiencias al inicializar
    super.onInit();
  }

  /// Método para cargar experiencias
  Future<void> fetchExperiences() async {
    try {
      isLoading(true);

      // Obtener lista de experiencias desde el servicio
      var experiences = await experienceService.getExperiences();

      // Procesar detalles de cada experiencia
      for (var experience in experiences) {
        await experience.loadDetails(experiences); // Método en ExperienceModel
      }

      experienceList.assignAll(experiences); // Actualizar la lista observable
    } catch (e) {
      // Mostrar error al usuario
      Get.snackbar('Error', 'No se pudieron cargar las experiencias',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}
