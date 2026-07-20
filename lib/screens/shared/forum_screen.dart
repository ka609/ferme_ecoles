import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_routes.dart';
import '../../providers/sujet_forum_provider.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SujetForumProvider>().fetchSujets();
    });
  }

  Future<void> _refresh() async {
    await context.read<SujetForumProvider>().fetchSujets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forum"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push(AppRoutes.nouveauSujet);
        },
        icon: const Icon(Icons.edit),
        label: const Text("Nouveau sujet"),
      ),

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 850,
            ),
            child: RefreshIndicator(
              onRefresh: _refresh,

              child: Consumer<SujetForumProvider>(
                builder: (context, provider, child) {

                  if (provider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (provider.sujets.isEmpty) {
                    return ListView(
                      children: const [
                        SizedBox(height: 120),

                        Icon(
                          Icons.forum_outlined,
                          size: 70,
                          color: Colors.grey,
                        ),

                        SizedBox(height: 20),

                        Center(
                          child: Text(
                            "Aucun sujet disponible",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        SizedBox(height: 8),

                        Center(
                          child: Text(
                            "Soyez le premier à lancer une discussion.",
                          ),
                        ),
                      ],
                    );
                  }

                  return ListView(
                    padding: const EdgeInsets.all(16),

                    children: [

                      Text(
                        "Forum communautaire",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "Échangez avec les producteurs et les consommateurs.",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                              color: Colors.grey,
                            ),
                      ),

                      const SizedBox(height: 24),

                      ...provider.sujets.map(
                        (sujet) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),

                          child: InkWell(
                            borderRadius:
                                BorderRadius.circular(18),

                            onTap: sujet.ferme
                                ? null
                                : () {
                                    context.push(
                                      AppRoutes.sujetDetail,
                                      extra: sujet,
                                    );
                                  },

                            child: Card(
                              elevation: 1,

                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(18),
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(18),

                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,

                                  children: [

                                    Row(
                                      children: [

                                        Icon(
                                          sujet.epingle
                                              ? Icons.push_pin
                                              : Icons.forum_outlined,
                                          color:
                                              sujet.epingle
                                                  ? Colors.orange
                                                  : Colors.green,
                                        ),

                                        const SizedBox(width: 10),

                                        Expanded(
                                          child: Text(
                                            sujet.titre,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),

                                        if (sujet.ferme)
                                          Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.red.shade50,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              "Fermé",
                                              style: TextStyle(
                                                color: Colors.red.shade700,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),

                                    const SizedBox(height: 14),

                                    Text(
                                      sujet.contenu,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        height: 1.5,
                                      ),
                                    ),

                                    const SizedBox(height: 18),

                                    Row(
                                      children: [

                                        if (sujet.epingle)
                                          Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.orange.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: const Text(
                                              "Épinglé",
                                            ),
                                          ),

                                        const Spacer(),

                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16,
                                          color: Colors.grey.shade600,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}