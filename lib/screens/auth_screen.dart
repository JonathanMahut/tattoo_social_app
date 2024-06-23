import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Sign in with Email'),
              onPressed: () {
                // Implémentez la logique de connexion par email ici
              },
            ),
            ElevatedButton(
              child: Text('Sign in with Google'),
              onPressed: () {
                context.read<AuthCubit>().signInWithGoogle();
              },
            ),
            ElevatedButton(
              child: Text('Sign in with Facebook'),
              onPressed: () {
                context.read<AuthCubit>().signInWithFacebook();
              },
            ),
          ],
        ),
      ),
    );
  }
}
