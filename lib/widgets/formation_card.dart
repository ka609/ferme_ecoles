import 'package:flutter/material.dart';
import '../../models/formation_model.dart';
import 'common/app_card.dart';

class FormationCard extends StatelessWidget {
  final Formation formation;
  final VoidCallback? onTap;

  const FormationCard({
    super.key,
    required this.formation,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      onTap: onTap,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.green.shade100,
                child: Icon(Icons.school, color: Colors.green.shade700),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  formation.titre,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            formation.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              if (formation.document != null)
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.picture_as_pdf, color: Colors.red, size: 18),
                    SizedBox(width: 4),
                    Text("Document"),
                  ],
                ),
              if (formation.video != null)
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_circle_fill, color: Colors.blue, size: 18),
                    SizedBox(width: 4),
                    Text("Vidéo"),
                  ],
                ),
            ],
          ),
          const Divider(height: 24),
          Row(
            children: [
              const Icon(Icons.person_outline, size: 18, color: Colors.grey),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  formation.auteurNom ?? "Administration",
                  style: theme.textTheme.bodySmall,
                ),
              ),
              if (formation.date != null)
                Text(
                  "${formation.date!.day.toString().padLeft(2, '0')}/${formation.date!.month.toString().padLeft(2, '0')}/${formation.date!.year}",
                  style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
            ],
          ),
        ],
      ),
    );
  }
}