import 'package:flutter/material.dart';

// classe que representa os veiculos no aplicativo 
class Veiculo {
  String marca;
  String modelo;
  int ano;
  double preco;
  String imagemUrl;
  Color corCard;

  Veiculo({
    required this.marca,
    required this.modelo,
    required this.ano,
    required this.preco,
    required this.imagemUrl,
    required this.corCard,
  });
}
