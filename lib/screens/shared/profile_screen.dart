import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = auth.user;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Mon compte"),
        ),
        body: const Center(
          child: Text("Utilisateur non connecté"),
        ),
      );
    }

    final nomAffiche = user.nomComplet.isNotEmpty
        ? user.nomComplet
        : user.username;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon compte"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.shade700,
                        Colors.green.shade400,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 42,
                        backgroundColor: Colors.white,
                        backgroundImage: user.photo != null &&
                                user.photo!.isNotEmpty
                            ? NetworkImage(user.photo!)
                            : null,
                        child: user.photo == null || user.photo!.isEmpty
                            ? Text(
                                nomAffiche.substring(0, 1).toUpperCase(),
                                style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        nomAffiche,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "@${user.username}",
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Chip(
                        label: Text(
                          user.role.name.toUpperCase(),
                        ),
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Informations personnelles",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _InfoTile(
                          icon: Icons.person_outline,
                          title: "Nom complet",
                          value: nomAffiche,
                        ),
                        _InfoTile(
                          icon: Icons.alternate_email,
                          title: "Nom d'utilisateur",
                          value: user.username,
                        ),
                        _InfoTile(
                          icon: Icons.email_outlined,
                          title: "Email",
                          value: user.email ?? "-",
                        ),
                        _InfoTile(
                          icon: Icons.phone_outlined,
                          title: "Téléphone",
                          value: user.telephone ?? "-",
                        ),
                        _InfoTile(
                          icon: Icons.location_on_outlined,
                          title: "Adresse",
                          value: user.adresse ?? "-",
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  "Paramètres",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                _ActionTile(
                  icon: Icons.edit_outlined,
                  title: "Modifier mon profil",
                  onTap: () {},
                ),

                const SizedBox(height: 10),

                _ActionTile(
                  icon: Icons.lock_outline,
                  title: "Modifier le mot de passe",
                  onTap: () {},
                ),

                const SizedBox(height: 28),

                FilledButton.icon(
                  onPressed: () async {
                    await context.read<AuthProvider>().logout();
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text("Déconnexion"),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(52),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.green.shade50,
        child: Icon(
          icon,
          color: Colors.green.shade700,
        ),
      ),
      title: Text(title),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.green.shade700,
        ),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}