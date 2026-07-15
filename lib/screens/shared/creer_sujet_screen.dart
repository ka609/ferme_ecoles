import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../providers/sujet_forum_provider.dart';

class CreerSujetScreen extends StatefulWidget {
  const CreerSujetScreen({super.key});

  @override
  State<CreerSujetScreen> createState() =>
      _CreerSujetScreenState();
}

class _CreerSujetScreenState
    extends State<CreerSujetScreen> {
  final _titreController =
      TextEditingController();

  final _contenuController =
      TextEditingController();

  Future<void> _creer() async {
    if (_titreController.text.trim().isEmpty ||
        _contenuController.text.trim().isEmpty) {
      return;
    }

    await context
        .read<SujetForumProvider>()
        .createSujet(
          titre: _titreController.text.trim(),
          contenu: _contenuController.text.trim(),
        );

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titreController.dispose();
    _contenuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nouveau sujet",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titreController,
              decoration: const InputDecoration(
                labelText: "Titre",
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _contenuController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Message",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _creer,
              child: const Text(
                "Publier",
              ),
            ),
          ],
        ),
      ),
    );
  }
}