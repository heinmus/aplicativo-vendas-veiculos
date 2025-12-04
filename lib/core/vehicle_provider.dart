
import 'package:flutter/material.dart';
import 'veiculo_model.dart';
import 'storage_service.dart';
import 'auth_service.dart';

class VehicleProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  final AuthService _authService; // Dependência do AuthService

  List<Vehicle> _vehicles = [];
  bool _isLoading = true;
  String? _errorMessage;

  List<Vehicle> get vehicles => _vehicles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  VehicleProvider(this._authService) { // Recebe o AuthService no construtor
    loadData();
  }

  String get _favoritesKey {
    // Cria uma chave única para os favoritos do usuário
    final user = _authService.username;
    if (user == null) return 'favorites_default'; // Fallback
    return 'favorites_$user';
  }

  Future<void> loadData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _vehicles = await _storageService.loadVehicles(_favoritesKey); // Passa a chave

      if (_vehicles.isEmpty) {
        _populateInitialData();
      }
    } catch (e) {
      _errorMessage = 'Erro ao carregar veículos: ${e.toString()}';
    }

    _isLoading = false;
    notifyListeners();
  }

  void addVehicle(Vehicle vehicle) {
    _vehicles.add(vehicle);
    notifyListeners();
    _storageService.saveVehicles(_vehicles, _favoritesKey); // Passa a chave
  }

  void toggleFavorite(String id) {
    final index = _vehicles.indexWhere((v) => v.id == id);
    if (index != -1) {
      _vehicles[index].isFavorite = !_vehicles[index].isFavorite;
      notifyListeners();
      _storageService.saveVehicles(_vehicles, _favoritesKey); // Passa a chave
    }
  }

  void _populateInitialData() {
    _vehicles = [
      // ... (os mesmos dados iniciais de antes)
      Vehicle(
          id: '1',
          brand: 'BMW',
          model: 'X1',
          year: 2023,
          price: 250000.00,
          imageUrl: 'assets/bmw x1.jfif',
          cardColor: Colors.blue.shade100),
      Vehicle(
          id: '2',
          brand: 'Ford',
          model: 'Fusion',
          year: 2021,
          price: 90000.00,
          imageUrl: 'assets/fusion.jfif',
          cardColor: Colors.red.shade100),
      Vehicle(
          id: '3',
          brand: 'Chevrolet',
          model: 'Onix',
          year: 2022,
          price: 75000.00,
          imageUrl: 'assets/onix.jfif',
          cardColor: Colors.yellow.shade100),
      Vehicle(
          id: '4',
          brand: 'Fiat',
          model: 'Pulse',
          year: 2020,
          price: 65000.00,
          imageUrl: 'assets/pulse.jfif',
          cardColor: Colors.green.shade100),
      Vehicle(
          id: '5',
          brand: 'Volkswagen',
          model: 'Tera',
          year: 2025,
          price: 150000.00,
          imageUrl: 'assets/tera.jpg',
          cardColor: Colors.blue.shade100),
      Vehicle(
          id: '6',
          brand: 'Fiat',
          model: 'Marea 2.0 Turbo',
          year: 2000,
          price: 50000.00,
          imageUrl: 'assets/marea.webp',
          cardColor: Colors.blue.shade100),
      Vehicle(
          id: '7',
          brand: 'Chevrolet',
          model: 'Celta',
          year: 2007,
          price: 20000.00,
          imageUrl: 'assets/celta.webp',
          cardColor: Colors.blue.shade100),
      Vehicle(
          id: '8',
          brand: 'Chevrolet',
          model: 'Chevette',
          year: 1985,
          price: 10000.00,
          imageUrl: 'assets/chevette.jpg',
          cardColor: Colors.blue.shade100),
      Vehicle(
          id: '9',
          brand: 'Hyunday',
          model: 'Hb20',
          year: 2025,
          price: 90000.00,
          imageUrl: 'assets/hb20.jpg',
          cardColor: Colors.blue.shade100),
      Vehicle(
          id: '10',
          brand: 'Peugeot',
          model: '206',
          year: 1999,
          price: 15000.00,
          imageUrl: 'assets/206.jfif',
          cardColor: Colors.blue.shade100),
    ];

    _storageService.saveVehicles(_vehicles, _favoritesKey); // Passa a chave
  }
}
