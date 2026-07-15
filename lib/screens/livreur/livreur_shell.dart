import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LivreurShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const LivreurShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          // Si on retape sur l'onglet déjà actif, on revient à sa racine
          // (efface la pile de navigation de cet onglet)
          initialLocation: index == navigationShell.currentIndex,
        ),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Accueil"),
          BottomNavigationBarItem(icon: Icon(Icons.delivery_dining), label: "Disponibles"),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: "Mes livraisons"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}