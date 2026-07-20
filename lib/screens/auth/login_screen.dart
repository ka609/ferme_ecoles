import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../providers/auth_provider.dart';
import '../../core/routes/route_utils.dart';
import '../../core/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // ---------------------------------------------------------------------
  // Logique métier : INCHANGÉE
  // ---------------------------------------------------------------------

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final auth = context.read<AuthProvider>();

    final success = await auth.login(
      _usernameController.text.trim(),
      _passwordController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      final role = auth.user?.role;

      debugPrint("LOGIN REUSSI ROLE : $role");

      final destination = RouteUtils.home(role);

      context.go(destination);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(auth.error ?? "Erreur de connexion"),
        ),
      );
    }
  }

  // ---------------------------------------------------------------------
  // UI
  // ---------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isWide = MediaQuery.sizeOf(context).width >= 900;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/catalogue');
      }
    },
  ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary,
              colorScheme.primary.withOpacity(0.85),
              colorScheme.tertiary.withOpacity(0.9),
            ],
          ),
        ),
        child: SafeArea(
          child: isWide
              ? _buildWideLayout(context)
              : _buildNarrowLayout(context),
        ),
      ),
    );
  }

  // ---- Grand écran : panneau coloré + carte de formulaire -------------------

  Widget _buildWideLayout(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 960, maxHeight: 600),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              Expanded(flex: 5, child: _buildBrandingPanel(context)),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
                  child: Center(
                    child: SingleChildScrollView(
                      child: _buildFormCard(context, showCardChrome: false),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---- Petit écran : bannière colorée en haut + carte blanche --------------

  Widget _buildNarrowLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        children: [
          const SizedBox(height: 24),
          _buildLogoBadge(context, size: 84, iconSize: 40),
          const SizedBox(height: 20),
          Text(
            "Bienvenue",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            "Connectez-vous pour accéder à votre espace",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
          ),
          const SizedBox(height: 32),
          _buildFormCard(context, showCardChrome: true),
        ],
      ),
    );
  }

  // ---- Panneau de branding (grand écran) ------------------------------------

  Widget _buildBrandingPanel(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.tertiary.withOpacity(0.85),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLogoBadge(context, size: 72, iconSize: 34),
          const SizedBox(height: 28),
          Text(
            "Bienvenue",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            "Connectez-vous pour retrouver vos produits, vos commandes et votre activité, au même endroit.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoBadge(BuildContext context, {required double size, required double iconSize}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      child: Icon(Icons.eco_outlined, color: Colors.white, size: iconSize),
    );
  }

  // ---- Carte du formulaire ---------------------------------------------------

  Widget _buildFormCard(BuildContext context, {required bool showCardChrome}) {
    final colorScheme = Theme.of(context).colorScheme;

    final form = Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showCardChrome) ...[
            Text(
              "Connexion",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
          ],
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: "Nom utilisateur",
              prefixIcon: Icon(Icons.person_outline, color: colorScheme.primary),
              filled: true,
              fillColor: colorScheme.surfaceContainerLow,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Veuillez saisir votre identifiant";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Mot de passe",
              prefixIcon: Icon(Icons.lock_outline, color: colorScheme.primary),
              filled: true,
              fillColor: colorScheme.surfaceContainerLow,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Veuillez saisir votre mot de passe";
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          Consumer<AuthProvider>(
            builder: (context, auth, child) {
              return SizedBox(
                height: 52,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: auth.isLoading ? null : _login,
                  child: auth.isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text("Se connecter"),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => context.go(AppRoutes.register),
            child: const Text("Créer un compte"),
          ),
        ],
      ),
    );

    if (!showCardChrome) return form;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: form,
    );
  }
}