import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _telephoneController = TextEditingController();

  String _role = "CLIENT";
  String _typeClient = "RESTAURANT";

  // ---------------------------------------------------------------------
  // Logique métier : INCHANGÉE
  // ---------------------------------------------------------------------

  @override
  void dispose() {
    _usernameController.dispose();
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _telephoneController.dispose();

    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final data = <String, dynamic>{
      "username": _usernameController.text.trim(),
      "nom": _nomController.text.trim(),
      "prenom": _prenomController.text.trim(),
      "email": _emailController.text.trim(),
      "password": _passwordController.text.trim(),
      "password_confirmation": _confirmPasswordController.text.trim(),
      "telephone": _telephoneController.text.trim(),
      "role": _role,
    };

    if (_role == "CLIENT") {
      data["type_client"] = _typeClient;
    }

    final success = await context.read<AuthProvider>().register(data);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Compte créé avec succès"),
        ),
      );

      // Pas de navigation manuelle ici : AuthProvider.register()
      // connecte automatiquement l'utilisateur, et le GoRouter
      // (via refreshListenable) redirige automatiquement selon le rôle.
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.read<AuthProvider>().error ??
                "Erreur lors de l'inscription",
          ),
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
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= 700;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/login');
            }
          },
        ),
        title: const Text("Créer un compte"),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 32 : 20,
                vertical: 24,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 28),
                    _sectionCard(
                      context: context,
                      title: "Type de compte",
                      icon: Icons.badge_outlined,
                      child: _buildRoleDropdown(context),
                    ),
                    const SizedBox(height: 20),
                    _sectionCard(
                      context: context,
                      title: "Informations personnelles",
                      icon: Icons.person_outline,
                      child: Column(
                        children: [
                          _buildResponsiveRow(
                            isWide,
                            TextFormField(
                              controller: _usernameController,
                              decoration: _fieldDecoration(
                                "Nom utilisateur",
                                Icons.alternate_email,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Champ obligatoire";
                                }
                                return null;
                              },
                            ),
                            null,
                          ),
                          const SizedBox(height: 16),
                          _buildResponsiveRow(
                            isWide,
                            TextFormField(
                              controller: _nomController,
                              decoration: _fieldDecoration(
                                "Nom",
                                Icons.badge_outlined,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Champ obligatoire";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _prenomController,
                              decoration: _fieldDecoration(
                                "Prénom",
                                Icons.badge_outlined,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Champ obligatoire";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildResponsiveRow(
                            isWide,
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: _fieldDecoration(
                                "Email",
                                Icons.email_outlined,
                              ),
                            ),
                            TextFormField(
                              controller: _telephoneController,
                              keyboardType: TextInputType.phone,
                              decoration: _fieldDecoration(
                                "Téléphone",
                                Icons.phone_outlined,
                              ),
                            ),
                          ),
                          if (_role == "CLIENT") ...[
                            const SizedBox(height: 16),
                            _buildTypeClientDropdown(context),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _sectionCard(
                      context: context,
                      title: "Sécurité",
                      icon: Icons.lock_outline,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: _fieldDecoration(
                              "Mot de passe",
                              Icons.lock_outline,
                            ),
                            validator: (value) {
                              if (value == null || value.length < 8) {
                                return "Minimum 8 caractères";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: _fieldDecoration(
                              "Confirmer le mot de passe",
                              Icons.lock_outline,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Confirmation obligatoire";
                              }

                              if (value != _passwordController.text) {
                                return "Les mots de passe ne correspondent pas";
                              }

                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    _buildSubmitButton(context),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---- En-tête -------------------------------------------------------------

  Widget _buildHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(Icons.person_add_alt_1_outlined,
              color: colorScheme.primary, size: 28),
        ),
        const SizedBox(height: 16),
        Text(
          "Rejoignez-nous",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          "Créez votre compte pour accéder à la marketplace agroécologique.",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }

  // ---- Carte de section, cohérente avec le reste de l'app -----------------

  Widget _sectionCard({
    required BuildContext context,
    required String title,
    IconData? icon,
    required Widget child,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, size: 18, color: colorScheme.primary),
                ),
                const SizedBox(width: 10),
              ],
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  // ---- Deux champs côte à côte sur grand écran, empilés sinon --------------

  Widget _buildResponsiveRow(bool isWide, Widget first, Widget? second) {
    if (second == null) return first;

    if (!isWide) {
      return Column(
        children: [
          first,
          const SizedBox(height: 16),
          second,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: first),
        const SizedBox(width: 16),
        Expanded(child: second),
      ],
    );
  }

  InputDecoration _fieldDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
    );
  }

  // ---- Type de compte -------------------------------------------------------

  Widget _buildRoleDropdown(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _role,
      decoration: _fieldDecoration("Type de compte", Icons.badge_outlined),
      items: const [
        DropdownMenuItem(
          value: "CLIENT",
          child: Text("Client"),
        ),
        DropdownMenuItem(
          value: "LIVREUR",
          child: Text("Livreur"),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _role = value!;
        });
      },
    );
  }

  Widget _buildTypeClientDropdown(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _typeClient,
      isExpanded: true,
      decoration: _fieldDecoration(
        "Type client",
        Icons.storefront_outlined,
      ),
      items: const [
        DropdownMenuItem(
          value: "RESTAURANT",
          child: Text(
            "Restaurant",
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DropdownMenuItem(
          value: "REVENDEUR",
          child: Text(
            "Revendeur / Transformateur",
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DropdownMenuItem(
          value: "AUTRE",
          child: Text(
            "Autre",
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _typeClient = value!;
        });
      },
    );
  }

  // ---- Bouton de soumission --------------------------------------------------

  Widget _buildSubmitButton(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return SizedBox(
          height: 52,
          child: FilledButton(
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: auth.isLoading ? null : _register,
            child: auth.isLoading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text("Créer le compte"),
          ),
        );
      },
    );
  }
}
