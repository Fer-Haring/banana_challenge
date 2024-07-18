import 'package:banana_challenge/providers/auth_provider.dart';
import 'package:banana_challenge/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
                width: double.infinity,
                height: 250,
                child: Text(
                  'Bienvenido',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 48),
                )),
            CustomFormFieldInput(
              controller: usernameController,
              labelText: 'Usuario',
            ),
            const SizedBox(height: 10),
            CustomFormFieldInput(
              controller: passwordController,
              isPassword: true,
              labelText: 'Contraseña',
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                  backgroundColor:
                      WidgetStateProperty.all(Theme.of(context).primaryColor),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
                onPressed: () async {
                  try {
                    final loginResponse = await ref.read(
                      authProvider({
                        "username": usernameController.text,
                        "password": passwordController.text,
                      }).future,
                    );
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('token', loginResponse.token);
                    GoRouter.of(context).go('/products');
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error during login: $e')),
                    );
                  }
                },
                child: const Text('Ingresar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
