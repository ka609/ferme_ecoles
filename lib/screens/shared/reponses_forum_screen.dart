import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/sujet_forum_model.dart';
import '../../providers/reponse_forum_provider.dart';

class ReponsesForumScreen extends StatefulWidget {
  final SujetForum sujet;

  const ReponsesForumScreen({
    super.key,
    required this.sujet,
  });

  @override
  State<ReponsesForumScreen> createState() =>
      _ReponsesForumScreenState();
}

class _ReponsesForumScreenState
    extends State<ReponsesForumScreen> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReponseForumProvider>().fetchReponses(
            widget.sujet.id,
          );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _envoyer() async {
    if (_controller.text.trim().isEmpty) {
      return;
    }

    await context
        .read<ReponseForumProvider>()
        .createReponse(
          sujetId: widget.sujet.id,
          contenu: _controller.text.trim(),
        );

    _controller.clear();

    await context
        .read<ReponseForumProvider>()
        .fetchReponses(
          widget.sujet.id,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Réponses"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ReponseForumProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  itemCount: provider.reponses.length,
                  itemBuilder: (context, index) {
                    final reponse =
                        provider.reponses[index];

                    return ListTile(
                      title: Text(
                        reponse.contenu,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Votre réponse",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _envoyer,
                  icon: const Icon(
                    Icons.send,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}