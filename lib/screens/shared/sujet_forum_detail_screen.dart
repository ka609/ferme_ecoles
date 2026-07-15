import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/routes/app_routes.dart';

import '../../models/sujet_forum_model.dart';


class SujetForumDetailScreen extends StatelessWidget {

  final SujetForum sujet;

  const SujetForumDetailScreen({
    super.key,
    required this.sujet,
  });


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Sujet",
        ),
      ),


      body: Padding(

        padding:
            const EdgeInsets.all(16),


        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,


          children: [

            Text(
              sujet.titre,

              style:
                  const TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),


            const SizedBox(height: 12),


            Text(
              sujet.contenu,
            ),


            const Spacer(),


            if (!sujet.ferme)

              SizedBox(

                width:
                    double.infinity,


                child:
                    ElevatedButton(

                  onPressed: () {

                    context.push(
                      AppRoutes.reponsesForum,
                      extra: sujet,
                      
                    );

                  },


                  child:
                      const Text(
                    "Voir les réponses",
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}