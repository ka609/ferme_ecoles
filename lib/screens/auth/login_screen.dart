import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();


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


    final success =
        await context.read<AuthProvider>().login(
          _usernameController.text.trim(),
          _passwordController.text.trim(),
        );


    if (!mounted) return;


    if (!success) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.read<AuthProvider>().error ??
                "Erreur de connexion",
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
          "Connexion",
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

                const SizedBox(height: 40),


                const Icon(
                  Icons.agriculture,
                  size: 80,
                ),


                const SizedBox(height: 20),


                const Text(
                  "FERME-ÉCOLE INTÉGRÉE",

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),


                const SizedBox(height: 40),


                TextFormField(

                  controller: _usernameController,

                  decoration: const InputDecoration(
                    labelText: "Nom utilisateur",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),


                  validator: (value) {

                    if (value == null ||
                        value.isEmpty) {

                      return "Veuillez saisir votre identifiant";

                    }

                    return null;
                  },
                ),


                const SizedBox(height: 16),


                TextFormField(

                  controller: _passwordController,

                  obscureText: true,

                  decoration: const InputDecoration(
                    labelText: "Mot de passe",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),


                  validator: (value) {

                    if (value == null ||
                        value.isEmpty) {

                      return "Veuillez saisir votre mot de passe";

                    }

                    return null;
                  },
                ),


                const SizedBox(height: 24),


                Consumer<AuthProvider>(

                  builder: (context, auth, child) {

                    return ElevatedButton(

                      onPressed: auth.isLoading
                          ? null
                          : _login,


                      child: auth.isLoading

                          ? const SizedBox(
                              height: 22,
                              width: 22,

                              child:
                                  CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )

                          : const Text(
                              "Se connecter",
                            ),
                    );

                  },
                ),


                const SizedBox(height: 16),


                TextButton(

                  onPressed: () {
                    context.go('/register');
                  },
                  child: const Text(
                    "Créer un compte",
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