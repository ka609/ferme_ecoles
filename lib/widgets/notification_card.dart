import 'package:flutter/material.dart';
import '../../models/notification_model.dart';
import 'common/app_card.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,          // ListTile gère déjà son padding
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: notification.lu
              ? Colors.grey.shade300
              : Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            _getIcon(notification.titre),
            color: notification.lu
                ? Colors.grey
                : Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(
          notification.titre,
          style: TextStyle(
            fontWeight: notification.lu ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Text(
          notification.message,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          _formatDate(notification.date),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case "COMMANDE": return Icons.shopping_cart;
      case "LIVRAISON": return Icons.local_shipping;
      case "PAIEMENT": return Icons.payment;
      case "FORMATION": return Icons.school;
      default: return Icons.notifications;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "";
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays == 0) {
      return "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
    }
    if (difference.inDays == 1) return "Hier";
    return "${date.day}/${date.month}/${date.year}";
  }
}