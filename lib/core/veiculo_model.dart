
import 'package:flutter/material.dart';

class Vehicle {
  final String id;
  final String brand;
  final String model;
  final int year;
  final double price;
  final String? imageUrl;
  final Color cardColor;
  bool isFavorite;

  Vehicle({
    String? id,
    required this.brand,
    required this.model,
    required this.year,
    required this.price,
    this.imageUrl,
    required this.cardColor,
    this.isFavorite = false,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'year': year,
      'price': price,
      'imageUrl': imageUrl,
      'cardColor': cardColor.toARGB32(),
      'isFavorite': isFavorite,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'],
      brand: map['brand'],
      model: map['model'],
      year: map['year'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      cardColor: Color(map['cardColor']),
      isFavorite: map['isFavorite'] ?? false,
    );
  }
}
