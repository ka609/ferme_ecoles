import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

      "username":
          _usernameController.text.trim(),

      "nom":
          _nomController.text.trim(),

      "prenom":
          _prenomController.text.trim(),

      "email":
          _emailController.text.trim(),

      "password":
          _passwordController.text.trim(),

      "password_confirmation":
          _confirmPasswordController.text.trim(),

      "telephone":
          _telephoneController.text.trim(),

      "role":
          _role,
    };


    if (_role == "CLIENT") {

      data["type_client"] = _typeClient;

    }


    final success =
        await context.read<AuthProvider>().register(
          data,
        );


    if (!mounted) return;


    if (success) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Compte créé avec succès",
          ),
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


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Créer un compte",
        ),
      ),


      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(24),

          child: Form(

            key: _formKey,

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.stretch,

              children: [

                DropdownButtonFormField<String>(

                  value: _role,

                  decoration: const InputDecoration(
                    labelText: "Type de compte",
                    border: OutlineInputBorder(),
                  ),

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
                ),


                const SizedBox(height: 16),


                TextFormField(

                  controller: _usernameController,

                  decoration: const InputDecoration(
                    labelText: "Nom utilisateur",
                    border: OutlineInputBorder(),
                  ),

                  validator: (value) {

                    if (value == null ||
                        value.isEmpty) {

                      return "Champ obligatoire";

                    }

                    return null;
                  },
                ),


                const SizedBox(height: 16),


                TextFormField(

                  controller: _nomController,

                  decoration: const InputDecoration(
                    labelText: "Nom",
                    border: OutlineInputBorder(),
                  ),

                  validator: (value) {

                    if (value == null ||
                        value.isEmpty) {

                      return "Champ obligatoire";

                    }

                    return null;
                  },
                ),


                const SizedBox(height: 16),


                TextFormField(

                  controller: _prenomController,

                  decoration: const InputDecoration(
                    labelText: "Prénom",
                    border: OutlineInputBorder(),
                  ),

                  validator: (value) {

                    if (value == null ||
                        value.isEmpty) {

                      return "Champ obligatoire";

                    }

                    return null;
                  },
                ),


                const SizedBox(height: 16),


                TextFormField(

                  controller: _emailController,

                  keyboardType:
                      TextInputType.emailAddress,

                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),


                const SizedBox(height: 16),


                TextFormField(

                  controller: _telephoneController,

                  keyboardType:
                      TextInputType.phone,

                  decoration: const InputDecoration(
                    labelText: "Téléphone",
                    border: OutlineInputBorder(),
                  ),
                ),


                const SizedBox(height: 16),


                TextFormField(

                  controller: _passwordController,

                  obscureText: true,

                  decoration: const InputDecoration(
                    labelText: "Mot de passe",
                    border: OutlineInputBorder(),
                  ),

                  validator: (value) {

                    if (value == null ||
                        value.length < 8) {

                      return "Minimum 8 caractères";

                    }

                    return null;
                  },
                ),


                const SizedBox(height: 16),


                TextFormField(

                  controller:
                      _confirmPasswordController,

                  obscureText: true,

                  decoration: const InputDecoration(
                    labelText: "Confirmer le mot de passe",
                    border: OutlineInputBorder(),
                  ),

                  validator: (value) {

                    if (value == null ||
                        value.isEmpty) {

                      return "Confirmation obligatoire";

                    }


                    if (value !=
                        _passwordController.text) {

                      return "Les mots de passe ne correspondent pas";

                    }

                    return null;
                  },
                ),


                if (_role == "CLIENT") ...[

                  const SizedBox(height: 16),


                  DropdownButtonFormField<String>(

                    value: _typeClient,

                    decoration: const InputDecoration(
                      labelText: "Type client",
                      border: OutlineInputBorder(),
                    ),

                    items: const [

                      DropdownMenuItem(
                        value: "RESTAURANT",
                        child: Text(
                          "Restaurant",
                        ),
                      ),

                      DropdownMenuItem(
                        value: "REVENDEUR",
                        child: Text(
                          "Revendeur / Transformateur",
                        ),
                      ),

                      DropdownMenuItem(
                        value: "AUTRE",
                        child: Text(
                          "Autre",
                        ),
                      ),

                    ],

                    onChanged: (value) {

                      setState(() {

                        _typeClient = value!;

                      });

                    },
                  ),
                ],


                const SizedBox(height: 24),


                Consumer<AuthProvider>(

                  builder: (context, auth, child) {

                    return ElevatedButton(

                      onPressed:
                          auth.isLoading
                              ? null
                              : _register,

                      child:
                          auth.isLoading

                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child:
                                      CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )

                              : const Text(
                                  "Créer le compte",
                                ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}