
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';
import 'veiculo_model.dart';

class FavoritesProvider with ChangeNotifier {
  final AuthService? _auth;
  List<Vehicle> _favorites = [];

  List<Vehicle> get favorites => _favorites;

  FavoritesProvider(this._auth) {
    _loadFavorites();
  }

  String get _favoritesKey => 'favorites_${_auth?.username}';

  Future<void> _loadFavorites() async {
    if (_auth == null || !_auth.isLoggedIn) return;

    final prefs = await SharedPreferences.getInstance();
    final favoritesString = prefs.getString(_favoritesKey);

    if (favoritesString != null) {
      final List<dynamic> json = jsonDecode(favoritesString);
      _favorites = json.map((item) => Vehicle.fromMap(item)).toList();
    } else {
      _favorites = [];
    }
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    if (_auth == null || !_auth.isLoggedIn) return;

    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> json =
        _favorites.map((item) => item.toMap()).toList();
    await prefs.setString(_favoritesKey, jsonEncode(json));
  }

  void toggleFavorite(Vehicle vehicle) {
    if (isFavorite(vehicle)) {
      _favorites.removeWhere((item) => item.id == vehicle.id);
    } else {
      _favorites.add(vehicle);
    }
    _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(Vehicle vehicle) {
    return _favorites.any((item) => item.id == vehicle.id);
  }
}
