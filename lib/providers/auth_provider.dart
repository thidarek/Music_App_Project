// lib/providers/auth_provider.dart

import 'package:flutter/material.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  // Local list storing registered users in app memory
  final List<User> _users = [
    // Pre-populated default user for testing
    User(
      id: '1',
      name: 'John Doe',
      email: 'test@example.com',
      password: 'password123',
    ),
  ];

  User? _currentUser;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  // ==================== REGISTER LOGIC ====================
  String? register({
    required String name,
    required String email,
    required String password,
  }) {
    // 1. Check if email already exists in the list
    final bool emailExists = _users.any(
      (user) => user.email.trim().toLowerCase() == email.trim().toLowerCase(),
    );

    if (emailExists) {
      return 'Email is already registered. Please log in.';
    }

    // 2. Create new User instance
    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      password: password,
    );

    // 3. Store new user in the local List
    _users.add(newUser);

    // 4. Log the new user in automatically
    _currentUser = newUser;
    notifyListeners();

    return null; // Null means registration succeeded
  }

  // ==================== LOGIN LOGIC ====================
  String? login({
    required String email,
    required String password,
  }) {
    try {
      // Compare entered email & password against every user in the list
      final matchedUser = _users.firstWhere(
        (u) =>
            u.email.trim().toLowerCase() == email.trim().toLowerCase() &&
            u.password == password,
      );

      // Match found -> Save current logged-in user
      _currentUser = matchedUser;
      notifyListeners();

      return null; // Null means login succeeded
    } catch (e) {
      // .firstWhere throws an exception if no user matches
      return 'Invalid email or password.';
    }
  }

  // ==================== LOGOUT LOGIC ====================
  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}