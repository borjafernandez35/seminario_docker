import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/experienceModel.dart';

class ExperienceCard extends StatelessWidget {
  final ExperienceModel experience;

  const ExperienceCard({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Propietario: ${experience.ownerDetails?.name ?? 'Sin datos'} (${experience.ownerDetails?.mail ?? ''})'),
            const SizedBox(height: 8),
            Text(
              'Descripción: ${experience.description}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
           const Text(
              'Participantes:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...?experience.participantsDetails?.map(
              (p) => Text('${p.name} (${p.mail})'),
            ),
          ],
        ),
      ),
    );
  }
}