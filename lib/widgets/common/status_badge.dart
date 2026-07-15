import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String statut;

  const StatusBadge({
    super.key,
    required this.statut,
  });

  static const Map<String, Color> _colors = {
    'LIVREE': Colors.green,
    'VALIDEE': Colors.green,
    'EN_COURS': Colors.blue,
    'PREPARATION': Colors.blue,
    'EN_ATTENTE': Colors.orange,
    'ANNULEE': Colors.red,
    'REFUSEE': Colors.red,
  };

  static const Map<String, String> _labels = {
    'LIVREE': 'Livrée',
    'VALIDEE': 'Validée',
    'EN_COURS': 'En cours',
    'PREPARATION': 'Préparation',
    'EN_ATTENTE': 'En attente',
    'ANNULEE': 'Annulée',
    'REFUSEE': 'Refusée',
  };

  @override
  Widget build(BuildContext context) {
    final key = statut.toUpperCase();
    final Color color = _colors[key] ?? Colors.grey;
    final String label = _labels[key] ?? statut;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}