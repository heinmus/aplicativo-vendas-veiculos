import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  static const _usernameKey = 'username';
  static const _passwordKey = 'password';
  static const _loggedInKey = 'isLoggedIn';

  bool _isLoggedIn = false;
  String? _username;

  bool get isLoggedIn => _isLoggedIn;
  String? get username => _username;

  // O construtor agora está vazio
  AuthService();

  // Método de inicialização público para ser chamado antes da execução do aplicativo
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool(_loggedInKey) ?? false;
    if (_isLoggedIn) {
      _username = prefs.getString(_usernameKey);
    }
    // Não há necessidade de chamar notifyListeners() aqui, pois o aplicativo ainda não foi construído.
    // O refreshListenable do roteador obterá o estado inicial correto.
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    if (username.trim().isEmpty || password.isEmpty) {
      return {'success': false, 'message': 'Nome de usuário e senha são obrigatórios.'};
    }

    final prefs = await SharedPreferences.getInstance();
    final storedUsername = prefs.getString(_usernameKey);
    final storedPassword = prefs.getString(_passwordKey);

    if (storedUsername == username.trim() && storedPassword == password) {
      _isLoggedIn = true;
      _username = username.trim();
      await prefs.setBool(_loggedInKey, true);
      notifyListeners();
      return {'success': true, 'message': 'Login bem-sucedido!'};
    } else {
      return {'success': false, 'message': 'Nome de usuário ou senha inválidos.'};
    }
  }

  Future<void> register(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username.trim());
    await prefs.setString(_passwordKey, password);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, false);
    _isLoggedIn = false;
    _username = null;
    notifyListeners();
  }
}