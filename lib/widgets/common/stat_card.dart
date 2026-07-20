import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {

  final String? title;

  final String? label;

  final String value;

  final IconData icon;

  final Color? color;

  final VoidCallback? onTap;


  const StatCard({

    super.key,

    this.title,

    this.label,

    required this.value,

    required this.icon,

    this.color,

    this.onTap,

  });



  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    final primaryColor =
        color ?? theme.colorScheme.primary;



    return Card(

      elevation: 1,

      clipBehavior: Clip.antiAlias,

      shape: RoundedRectangleBorder(

        borderRadius:

        BorderRadius.circular(16),

      ),



      child: InkWell(

        borderRadius:

        BorderRadius.circular(16),


        onTap: onTap,


        child: Padding(

          padding:

          const EdgeInsets.all(12),


          child: Column(

            crossAxisAlignment:

            CrossAxisAlignment.start,


            mainAxisAlignment:

            MainAxisAlignment.center,


            children: [



              Row(

                mainAxisAlignment:

                MainAxisAlignment.spaceBetween,


                children: [


                  Container(

                    padding:

                    const EdgeInsets.all(8),


                    decoration:

                    BoxDecoration(

                      color:

                      primaryColor

                          .withOpacity(.15),


                      borderRadius:

                      BorderRadius.circular(10),

                    ),


                    child:

                    Icon(

                      icon,

                      color:

                      primaryColor,

                      size: 22,

                    ),

                  ),



                  Icon(

                    Icons.arrow_forward_ios,

                    size: 14,

                    color:

                    Colors.grey.shade400,

                  ),


                ],

              ),




              const SizedBox(height: 10),




              Text(

                value,

                maxLines: 1,

                overflow:

                TextOverflow.ellipsis,


                style:

                theme.textTheme.titleLarge

                    ?.copyWith(

                  fontWeight:

                  FontWeight.bold,

                ),

              ),




              const SizedBox(height: 4),




              Text(

                title ?? label ?? "",


                maxLines: 2,

                overflow:

                TextOverflow.ellipsis,


                style:

                theme.textTheme.bodySmall,

              ),


            ],

          ),

        ),

      ),

    );

  }

}