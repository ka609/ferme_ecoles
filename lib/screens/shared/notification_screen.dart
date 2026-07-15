import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/notification_provider.dart';
import '../../widgets/notification_card.dart';
import '../../widgets/common/empty_state.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() =>
      _NotificationScreenState();
}


class _NotificationScreenState
    extends State<NotificationScreen> {


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<NotificationProvider>()
          .fetchNotifications();
    });
  }


  Future<void> _refresh() async {
    await context
        .read<NotificationProvider>()
        .fetchNotifications();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Notifications",
        ),
      ),


      body: RefreshIndicator(

        onRefresh: _refresh,


        child: Consumer<NotificationProvider>(

          builder: (context, provider, child) {


            if (provider.isLoading) {

              return const Center(
                child: CircularProgressIndicator(),
              );
            }


            if (provider.notifications.isEmpty) {
                 return const EmptyState(
                      icon: Icons.notifications_none,
                    message: "Aucune notification pour le moment",
             );
          }


            return ListView.builder(

              padding:
                  const EdgeInsets.all(16),


              itemCount:
                  provider.notifications.length,


              itemBuilder: (context, index) {

                final notification =
                    provider.notifications[index];


                return NotificationCard(

                  notification:
                      notification,


                  onTap: () {

                    if (!notification.lu) {

                      provider.readNotification(
                        notification.id,
                      );

                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}