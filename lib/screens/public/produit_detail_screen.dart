import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/produit_model.dart';

class ProduitDetailScreen extends StatelessWidget {
  final Produit produit;

  const ProduitDetailScreen({
    super.key,
    required this.produit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Détail du produit",
        ),
      ),


      body: SafeArea(
        child: CustomScrollView(
          slivers: [

            // Image produit
            SliverToBoxAdapter(
              child: SizedBox(
                height: 280,

                child: produit.image != null
                    ? Image.network(
                        produit.image!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )

                    : Container(
                        color: Colors.grey.shade200,

                        child: const Icon(
                          Icons.image,
                          size: 80,
                        ),
                      ),
              ),
            ),


            // Informations
            SliverPadding(
              padding: const EdgeInsets.all(16),

              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(
                      produit.nom,

                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                    const SizedBox(height: 10),


                    Text(
                      "${produit.prix} FCFA",

                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),


                    const SizedBox(height: 20),


                    const Text(
                      "Description",

                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                    const SizedBox(height: 8),


                    Text(
                      produit.description ??
                          "Aucune description disponible.",
                    ),


                    const SizedBox(height: 20),


                    const Text(
                      "Producteur",

                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                    const SizedBox(height: 8),


                    if (produit.producteurNom != null)

                      Text(
                        produit.producteurNom ?? "",
                      ),


                    const SizedBox(height: 20),


                    // Certification
                    Container(
                      padding:
                          const EdgeInsets.all(12),

                      decoration:
                          BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(12),

                        border: Border.all(
                          color:
                              Colors.grey.shade300,
                        ),
                      ),

                      child: const Row(
                        children: [

                          Icon(
                            Icons.verified,
                          ),

                          SizedBox(width: 10),

                          Text(
                            "Certification BIO SPG active",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),


      // Action panier
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: SizedBox(
            height: 50,

            child: ElevatedButton(
              onPressed: () {

                // Vérification authentification
                context.push('/login');

              },

              child: const Text(
                "Ajouter au panier",
              ),
            ),
          ),
        ),
      ),
    );
  }
}