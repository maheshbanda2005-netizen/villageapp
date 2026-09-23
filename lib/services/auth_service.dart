import 'package:flutter/foundation.dart';

/// Lightweight local auth for demo / offline village use.
/// Pure Dart (no native plugins) to avoid Windows C:/D: Kotlin cache issues.
class AuthUser {
  final String name;
  final String phone;
  final String village;
  final String email;

  const AuthUser({
    required this.name,
    required this.phone,
    required this.village,
    this.email = '',
  });

  AuthUser copyWith({
    String? name,
    String? phone,
    String? village,
    String? email,
  }) {
    return AuthUser(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      village: village ?? this.village,
      email: email ?? this.email,
    );
  }
}

class AuthService extends ChangeNotifier {
  AuthService._();
  static final AuthService instance = AuthService._();

  bool _loggedIn = false;
  bool _onboarded = false;
  bool _isTelugu = false;
  String _name = '';
  String _phone = '';
  String _village = '';
  String _email = '';
  String _password = '';

  bool get isTeluguLang => _isTelugu;

  Future<bool> isLoggedIn() async => _loggedIn;

  Future<bool> hasCompletedOnboarding() async => _onboarded;

  Future<bool> isTelugu() async => _isTelugu;

  Future<void> setVillage(String village) async {
    _village = village;
    notifyListeners();
  }

  Future<void> setLanguage({required bool isTelugu}) async {
    _isTelugu = isTelugu;
    _onboarded = true;
    notifyListeners();
  }

  Future<AuthUser?> currentUser() async {
    if (!_loggedIn) return null;
    return AuthUser(
      name: _name.isEmpty ? 'Villager' : _name,
      phone: _phone,
      village: _village.isEmpty ? 'My Village' : _village,
      email: _email,
    );
  }

  Future<String?> signUp({
    required String name,
    required String phone,
    required String village,
    required String password,
    String email = '',
  }) async {
    if (name.trim().length < 2) return 'Please enter your full name';
    if (phone.trim().length < 10) return 'Enter a valid 10-digit phone number';
    if (village.trim().isEmpty) return 'Please enter your village name';
    if (password.length < 6) return 'Password must be at least 6 characters';

    _name = name.trim();
    _phone = phone.trim();
    _village = village.trim();
    _email = email.trim();
    _password = password;
    _loggedIn = true;
    notifyListeners();
    return null;
  }

  Future<String?> login({
    required String phone,
    required String password,
  }) async {
    // First-time / demo: allow login and create a lightweight profile.
    if (_phone.isEmpty || _password.isEmpty) {
      if (phone.trim().length < 10) return 'Enter a valid phone number';
      if (password.length < 6) return 'Password must be at least 6 characters';
      _phone = phone.trim();
      _password = password;
      _name = 'Rahul';
      _village = 'Kothapally';
      _loggedIn = true;
      notifyListeners();
      return null;
    }

    if (phone.trim() != _phone || password != _password) {
      return 'Invalid phone number or password';
    }

    _loggedIn = true;
    notifyListeners();
    return null;
  }

  Future<String?> resetPassword({
    required String phone,
    required String newPassword,
  }) async {
    if (_phone.isEmpty || _phone != phone.trim()) {
      return 'No account found with this phone number';
    }
    if (newPassword.length < 6) return 'Password must be at least 6 characters';
    _password = newPassword;
    return null;
  }

  Future<void> logout() async {
    _loggedIn = false;
    notifyListeners();
  }
}
