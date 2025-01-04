import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/userModel.dart';
import 'package:flutter_application_1/services/user.dart';

class ExperienceModel with ChangeNotifier {
  final String id;
  final owner;
  final List<String> participants;
  String description;

  UserModel? ownerDetails; // Detalles del propietario
  List<UserModel>? participantsDetails;

  // Constructor
  ExperienceModel({
    required this.id,
    required this.owner,
    required List<String?> participants,
    required this.description,
    this.ownerDetails,
    this.participantsDetails,
  }) : participants = participants.whereType<String>().toList();

  // Método para crear una instancia desde un JSON
   factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: _validateObjectId(json['_id']),
      owner: _validateObjectId(json['owner']?['_id']),
      participants: (json['participants'] as List?)
              ?.map((p) => _validateObjectId(p['_id']))
              .where((id) => id.isNotEmpty)
              .toList() ??
          [],
      description: json['description']?.toString() ?? 'Sin descripción',
    );
  }

  // Helper function to validate ObjectId
  static String _validateObjectId(dynamic id) {
    if (id is String && id.isNotEmpty) {
      return id;
    }
    print("Invalid ObjectId: $id");
    return ''; // Return an empty string if id is invalid
  }

  // Método para convertir el modelo en JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'owner': owner, // Solo el ID
      'participants': participants, // IDs de los participantes
      'description': description,
    };
  }

  Future<void> loadDetails(List<ExperienceModel> experiences) async {
    final userService = UserService();

    try {
      // Obtener solo los IDs de los usuarios
      final usersId = await userService.getUsersId();

      if (usersId.isEmpty) {
        print("No se encontraron usuarios.");
        return;
      }

      print('GET IDs: $usersId');

      for (var experience in experiences) {
        print('Procesando experiencia ID: ${experience.id}');

        // Validar y cargar el propietario
        if (usersId.contains(experience.owner)) {
          final ownerDetails = await userService.getUser(experience.owner);
          experience.ownerDetails = ownerDetails;
          print(
              'Detalles del propietario cargados: ${ownerDetails.name} para experiencia ${experience.id}');
                } else {
          print(
              'El propietario con ID ${experience.owner} no está en la lista de usuarios.');
        }

        // Validar y cargar los detalles de los participantes
         experience.participantsDetails = await Future.wait(
        experience.participants.map((participantId) async {
          if (usersId.contains(participantId)) {
            return await userService.getUser(participantId);
          }
          return null; // Ignorar IDs de participantes no válidos
        }),
      ).then((list) => list.whereType<UserModel>().toList());

        print(
            'Detalles de participantes cargados para experiencia ${experience.id}: '
            '${experience.participantsDetails?.map((e) => e.name).toList()}');
      }

      // Notificar cambios
      notifyListeners();
    } catch (e) {
      print("Error al cargar detalles de las experiencias: $e");
    }
  }
}
