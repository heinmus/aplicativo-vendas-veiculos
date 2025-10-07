import 'package:flutter/material.dart';
import 'package:myapp/core/veiculo_model.dart';

// tela de quando o cliente clica no produto no catalogo
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recupera o objeto passado pela navegação
    final veiculo = ModalRoute.of(context)!.settings.arguments as Veiculo?;

    if (veiculo == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Erro')),
        body: const Center(
          child: Text('Veículo não encontrado.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${veiculo.marca} ${veiculo.modelo}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // imagem do veículo (ou ícone de erro se não carregar)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                veiculo.imagemUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) {
                  return Container(
                    height: 200,
                    color: veiculo.corCard.withAlpha(120),
                    child: const Center(
                      child: Icon(Icons.error, size: 45),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            _infoRow('Marca:', veiculo.marca),
            _infoRow('Modelo:', veiculo.modelo),
            _infoRow('Ano:', veiculo.ano.toString()),
            _infoRow('Preço:', 'R\$ ${veiculo.preco.toStringAsFixed(2)}', isPrice: true),

            const SizedBox(height: 25),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Interesse no ${veiculo.modelo} enviado!'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.phone),
                label: const Text('Entrar em contato'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // widget que exibe as linhas com as iformaçoes
  Widget _infoRow(String titulo, String valor, {bool isPrice = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titulo,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Text(
            valor,
            style: TextStyle(
              fontSize: 17,
              color: isPrice ? Colors.green.shade700 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
