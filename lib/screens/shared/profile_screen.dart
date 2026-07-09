import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {

    final auth =
        context.watch<AuthProvider>();

    final user =
        auth.user;


    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mon compte",
        ),
      ),


      body: user == null

          ? const Center(
              child: Text(
                "Utilisateur non connecté",
              ),
            )


          : ListView(
              padding:
                  const EdgeInsets.all(16),

              children: [

                // Informations utilisateur
                CircleAvatar(
                  radius: 40,

                  child: Text(
                    user.username
                        .substring(0, 1)
                        .toUpperCase(),

                    style:
                        const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),


                const SizedBox(height: 20),


                Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.all(16),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          "Nom utilisateur",
                          style:
                              Theme.of(context)
                                  .textTheme
                                  .bodySmall,
                        ),


                        Text(
                          user.username,
                          style:
                              const TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),


                        const SizedBox(height: 12),


                        Text(
                          "Email",
                          style:
                              Theme.of(context)
                                  .textTheme
                                  .bodySmall,
                        ),


                        Text(
                          user.email ?? "",
                        ),


                        const SizedBox(height: 12),


                        Text(
                          "Rôle",
                          style:
                              Theme.of(context)
                                  .textTheme
                                  .bodySmall,
                        ),


                        Text(
                          user.role.name,
                        ),
                      ],
                    ),
                  ),
                ),


                const SizedBox(height: 20),



                // Actions
                ListTile(

                  leading:
                      const Icon(
                    Icons.edit_outlined,
                  ),


                  title:
                      const Text(
                    "Modifier mon profil",
                  ),


                  onTap: () {

                    // écran modification profil à ajouter

                  },
                ),



                ListTile(

                  leading:
                      const Icon(
                    Icons.lock_outline,
                  ),


                  title:
                      const Text(
                    "Modifier le mot de passe",
                  ),


                  onTap: () {

                    // écran changement mot de passe à ajouter

                  },
                ),



                ListTile(

                  leading:
                      const Icon(
                    Icons.logout,
                  ),


                  title:
                      const Text(
                    "Déconnexion",
                  ),


                  onTap: () async {

                    await context
                        .read<AuthProvider>()
                        .logout();

                  },
                ),
              ],
            ),
    );
  }
}