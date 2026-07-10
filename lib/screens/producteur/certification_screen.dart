import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/certification_provider.dart';

class CertificationScreen extends StatefulWidget {
  const CertificationScreen({super.key});

  @override
  State<CertificationScreen> createState() =>
      _CertificationScreenState();
}

class _CertificationScreenState
    extends State<CertificationScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<CertificationProvider>()
          .fetchCertifications();
    });
  }

  Future<void> _envoyerDemande() async {
    final success = await context
        .read<CertificationProvider>()
        .createCertification(
          {
            "description":
                "Demande de certification BIO SPG",
          },
        );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? "Demande envoyée"
              : "Erreur lors de l'envoi",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Certification BIO SPG",
        ),
      ),

      body: Consumer<CertificationProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.certifications.isEmpty) {
            return Center(
              child: ElevatedButton(
                onPressed: _envoyerDemande,

                child: const Text(
                  "Demander une certification",
                ),
              ),
            );
          }

          final certification =
              provider.certifications.first;

          return Padding(
            padding: const EdgeInsets.all(16),

            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      "Statut : ${certification["statut"] ?? "En attente"}",

                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    Text(
                      certification["description"] ??
                          "Aucune description",
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}