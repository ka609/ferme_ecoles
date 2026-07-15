import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class ClientShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ClientShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final isLogged = context.watch<AuthProvider>().isAuthenticated;

    return Scaffold(
      body: navigationShell,
      // Pas de bottom nav pour un visiteur non connecté : seul le catalogue
      // (onglet 0) lui est accessible, la nav n'aurait pas de sens.
      bottomNavigationBar: isLogged
          ? BottomNavigationBar(
              currentIndex: navigationShell.currentIndex,
              onTap: (index) => navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              ),
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.storefront_outlined),
                  label: "Catalogue",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long_outlined),
                  label: "Commandes",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_shipping_outlined),
                  label: "Livraison",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: "Compte",
                ),
              ],
            )
          : null,
    );
  }
}