import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../providers/sujet_forum_provider.dart';


class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() =>
      _ForumScreenState();
}


class _ForumScreenState extends State<ForumScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<SujetForumProvider>()
          .fetchSujets();
    });
  }


  Future<void> _refresh() async {
    await context
        .read<SujetForumProvider>()
        .fetchSujets();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Forum",
        ),
      ),


      floatingActionButton: FloatingActionButton(

        onPressed: () {

          context.push(
            "/forum/nouveau",
          );

        },


        child: const Icon(
          Icons.add,
        ),
      ),


      body: RefreshIndicator(

        onRefresh: _refresh,


        child: Consumer<SujetForumProvider>(

          builder: (context, provider, child) {


            if (provider.isLoading) {

              return const Center(
                child: CircularProgressIndicator(),
              );
            }


            if (provider.sujets.isEmpty) {

              return const Center(
                child: Text(
                  "Aucun sujet disponible",
                ),
              );
            }


            return ListView.builder(

              padding:
                  const EdgeInsets.all(16),


              itemCount:
                  provider.sujets.length,


              itemBuilder: (context, index) {

                final sujet =
                    provider.sujets[index];


                return Card(

                  margin:
                      const EdgeInsets.only(
                    bottom: 12,
                  ),


                  child: ListTile(

                    leading: sujet.epingle

                        ? const Icon(
                            Icons.push_pin,
                          )

                        : const Icon(
                            Icons.forum_outlined,
                          ),


                    title: Text(
                      sujet.titre,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                    ),


                    subtitle: Text(
                      sujet.contenu,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                    ),


                    trailing:
                        sujet.ferme

                            ? const Icon(
                                Icons.lock_outline,
                              )

                            : null,


                    onTap: () {

                      if (!sujet.ferme) {

                        context.push(
                          "/forum/${sujet.id}",
                          extra: sujet,
                        );

                      }

                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}