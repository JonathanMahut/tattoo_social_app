import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/auth_service.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final String? error;

  AuthState({required this.status, this.error});
}

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit(this._authService) : super(AuthState(status: AuthStatus.initial));

  final dummyNavigatorKey = GlobalKey<NavigatorState>();

  Future<void> signIn(String email, String password) async {
    try {
      final user =
          await _authService.signIn(email, password, dummyNavigatorKey);
      if (user != null) {
        emit(AuthState(status: AuthStatus.authenticated));
      } else {
        emit(AuthState(
            status: AuthStatus.unauthenticated, error: "Invalid credentials"));
      }
    } catch (e) {
      emit(AuthState(status: AuthStatus.unauthenticated, error: e.toString()));
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      final user =
          await _authService.signUp(email, password, dummyNavigatorKey);
      if (user != null) {
        emit(AuthState(status: AuthStatus.authenticated));
      } else {
        emit(AuthState(
            status: AuthStatus.unauthenticated, error: "Signup failed"));
      }
    } catch (e) {
      emit(AuthState(status: AuthStatus.unauthenticated, error: e.toString()));
    }
  }

  Future<void> signOut() async {
    await _authService.signOut(dummyNavigatorKey);
    emit(AuthState(status: AuthStatus.unauthenticated));
  }

  Future<void> signInWithGoogle() async {
    try {
      final user = await _authService.signInWithGoogle(dummyNavigatorKey);
      if (user != null) {
        emit(AuthState(status: AuthStatus.authenticated));
      } else {
        emit(AuthState(
            status: AuthStatus.unauthenticated,
            error: "Google sign-in failed"));
      }
    } catch (e) {
      emit(AuthState(status: AuthStatus.unauthenticated, error: e.toString()));
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final user = await _authService.signInWithFacebook(dummyNavigatorKey);
      if (user != null) {
        emit(AuthState(status: AuthStatus.authenticated));
      } else {
        emit(AuthState(
            status: AuthStatus.unauthenticated,
            error: "Facebook sign-in failed"));
      }
    } catch (e) {
      emit(AuthState(status: AuthStatus.unauthenticated, error: e.toString()));
    }
  }
}
