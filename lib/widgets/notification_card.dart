import 'package:flutter/material.dart';

import '../models/notification_model.dart';


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

    return Card(

      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),


      color: notification.lu
          ? null
          : Colors.green.shade50,


      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(12),
      ),


      child: InkWell(

        borderRadius:
            BorderRadius.circular(12),


        onTap: onTap,


        child: Padding(

          padding:
              const EdgeInsets.all(16),


          child: Row(

            crossAxisAlignment:
                CrossAxisAlignment.start,


            children: [

              Icon(

                notification.lu
                    ? Icons.notifications_none
                    : Icons.notifications_active,

              ),


              const SizedBox(width: 12),


              Expanded(

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,


                  children: [

                    Text(

                      notification.titre,

                      style:
                          TextStyle(

                        fontWeight:
                            notification.lu
                                ? FontWeight.normal
                                : FontWeight.bold,
                      ),
                    ),


                    const SizedBox(height: 6),


                    Text(
                      notification.message,

                      maxLines:
                          2,

                      overflow:
                          TextOverflow.ellipsis,
                    ),


                    if (notification.date != null)

                      Padding(

                        padding:
                            const EdgeInsets.only(
                          top: 6,
                        ),


                        child: Text(

                          "${notification.date!.day}/"
                          "${notification.date!.month}/"
                          "${notification.date!.year}",

                          style:
                              const TextStyle(
                            fontSize:
                                12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}