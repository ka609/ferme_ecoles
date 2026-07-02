import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';
import 'screens/client/home_screen.dart';

void main() {
  runApp(const FermeEcoleApp());
}

class FermeEcoleApp extends StatelessWidget {
  const FermeEcoleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        // TODO: ajouter AuthProvider une fois l'écran de connexion branché,
        // et router vers HomeScreen (Client) ou HomeProducteurScreen selon
        // le rôle renvoyé par /api/auth/login/.
      ],
      child: MaterialApp(
        title: 'FermeEcole',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        // En attendant l'écran de connexion, on démarre directement sur
        // l'accueil Client pour visualiser l'adaptation du template Ogani.
        home: const HomeScreen(),
      ),
    );
  }
}