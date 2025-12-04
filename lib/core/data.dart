import 'package:flutter/material.dart';
import 'veiculo_model.dart';

// Lista de alguns carros que seram vendidos 
final listaVeiculos = [
  Veiculo(
    marca: 'BMW',
    modelo: 'X1',
    ano: 2023,
    preco: 250000.00,
    imagemUrl: 'assets/bmw x1.jfif',
    corCard: Colors.blue.shade100,
  ),
  Veiculo(
    marca: 'Ford',
    modelo: 'Fusion',
    ano: 2021,
    preco: 90000.00,
    imagemUrl: 'assets/fusion.jfif',
    corCard: Colors.red.shade100,
  ),
  Veiculo(
    marca: 'Chevrolet',
    modelo: 'Onix',
    ano: 2022,
    preco: 75000.00,
    imagemUrl: 'assets/onix.jfif',
    corCard: Colors.yellow.shade100,
  ),
  Veiculo(
    marca: 'Fiat',
    modelo: 'Pulse',
    ano: 2020,
    preco: 65000.00,
    imagemUrl: 'assets/pulse.jfif',
    corCard: Colors.green.shade100,
  ),
  Veiculo(
    marca: 'Vowksvagen',
    modelo: 'Tera',
    ano: 2025,
    preco: 150000.00,
    imagemUrl: 'assets/tera.jpg',
    corCard: Colors.blue.shade100,
  ),
];

final Map<String, String> infoApp = {
  'appNome': 'App de venda de veículos',
  'versao': '1.0.0',
};

final List<Map<String, String?>> infoMembros = [
  {
    'nome': 'Oresto B. Olimpio Neto',
    'funcao': 'Desenvolvedor',
  },
  {
    'nome': 'Francisco Ryan dos Santos Silva',
    'funcao': 'Desenvolvedor',
  },
  {
    'nome': 'José Maria Santos da Rocha Junior',
    'funcao': 'Desenvolvedor',
  },
  {
    'nome': 'Pedro Henrique Feitosa Araújo',
    'funcao': 'Desenvolvedor',
  },
];
